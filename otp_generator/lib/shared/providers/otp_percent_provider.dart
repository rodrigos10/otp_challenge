import 'package:flutter/foundation.dart';

class OtpPercentProvider extends ChangeNotifier {
  double _tempoRestante = 1;

  double get tempoRestante => _tempoRestante;

  updateTempoRestante(double novoTempoRestante) {
    _tempoRestante = novoTempoRestante;
    notifyListeners();
  }
}
