import 'package:flutter/material.dart';
import 'package:otp_generator/shared/providers/otp_datasource.dart';
import 'package:otp_generator/shared/providers/user_datasource.dart';
import 'package:otp_plus/otp_inputs.dart';
import 'package:otp_plus/utils/enum/otp_field_shape.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  int duration = 1;
  bool isValidatingToken = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = Provider.of<OtpDatasource>(context, listen: true);
    final userProvider = Provider.of<UserDatasource>(context, listen: true);

    // faz a animação entrar em loop
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("Animação terminou!");

        // final provider = context.read<OtpDatasource>();

        String userId = userProvider.currentUser?.userId ?? '...';

        provider.currentUserId = userId;
        provider.fetchOtp().then((response) {
          provider.updateDuration = response.duration;

          setState(() {
            duration = response.duration;
            _controller.duration = Duration(seconds: duration);
          });
        });

        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  renderUiBotaoValidarToken() {
    return Positioned(
      bottom: 80,
      child: ElevatedButton(
        onPressed: () {
          // Ação ao pressionar o botão
          setState(() {
            isValidatingToken = !isValidatingToken;
          });
        },
        child: Text('Validar Token'),
      ),
    );
  }

  renderOtpFields(
    double screenHeight,
    OtpDatasource provider,
    UserDatasource userProvider,
  ) {
    return AnimatedOpacity(
      opacity: isValidatingToken ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutQuad,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.only(
          bottom: isValidatingToken ? screenHeight * .15 : 0,
        ),
        curve: Curves.easeInOutQuad,
        child: OtpPlusInputs(
          size: 50,
          length: 6,
          enabled: true,
          ignorePointers: false,
          obscureText: false,
          shape: OtpFieldShape.square,
          textDirection: TextDirection.ltr,
          onChanged: (code) {
            debugPrint('On Changed : $code');
            provider.updateOtpTyped = code;
          },
          onSubmit: (code) {
            debugPrint('On Submit : $code');
            provider.verifyOtp(userProvider.currentUser!.userId);
          },
        ),
      ),
    );
  }

  // usa animatedcontainer para mostrar um círculo verde ou vermelho de acordo com o status da validação
  renderOtpValidationStatus(OtpDatasource provider) {

    bool valid = provider.otpValidation?.valid ?? false;

    return isValidatingToken? AnimatedContainer(
      duration: Duration(milliseconds: 1500),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: valid ? Colors.green : Colors.red,
        shape: BoxShape.circle
        ),
    ) : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDatasource>(context, listen: true);
    final otpProvider = Provider.of<OtpDatasource>(context, listen: true);
    final isLogged = userProvider.currentUser != null;

    /// altura total da tela
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: Text(
          'Olá, ${userProvider.currentUser?.userName ?? '...'}',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                        value: 1.0 - _controller.value, // vai de 1 → 0,
                        strokeWidth: 15,
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  },
                ),
                Text(
                  '${otpProvider.otpResponse?.token ?? '...'}',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
                // Botão de digitar token para validar
                renderUiBotaoValidarToken(),
              ],
            ),

            SizedBox(height: 60),
            renderOtpFields(screenHeight, otpProvider, userProvider),
            renderOtpValidationStatus(otpProvider),
            AnimatedContainer(
              height: isValidatingToken ? screenHeight * .2 : 0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutQuad,
            ),
          ],
        ),
      ),
    );
  }
}
