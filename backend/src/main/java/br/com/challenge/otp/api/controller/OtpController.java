package br.com.challenge.otp.api.controller;

import java.time.Instant;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.challenge.otp.api.model.OtpResponse;
import br.com.challenge.otp.api.model.TokenValidationResult;
import br.com.challenge.otp.domain.model.ConfigEntity;
import br.com.challenge.otp.domain.model.OtpEntity;
import br.com.challenge.otp.domain.repository.ConfigRepository;
import br.com.challenge.otp.domain.repository.OtpRepository;
import br.com.challenge.otp.domain.repository.UserRepository;

@RestController
@RequestMapping("/api/otp")
public class OtpController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OtpRepository repository;

    @Autowired
    private ConfigRepository configRepository;

    @PostMapping("/{user_id}")
    public ResponseEntity<OtpResponse> criarOtp(@PathVariable("user_id") String userId) {

        if (!userRepository.existsById(userId)) {
            return ResponseEntity.notFound().build();
        }

        ConfigEntity config = configRepository
                .findByConfigName("OTP_DURATION_SECONDS")
                .orElseThrow(() -> new RuntimeException("Configuração OTP_DURATION_SECONDS não encontrada"));

        int randomNumber = (int) (Math.random() * 900000) + 100000;
        String token = String.valueOf(randomNumber);

        OtpEntity otp = OtpEntity.builder()
                .token(token)
                .userId(userId)
                .expiresAt(Instant.now().plusSeconds(Long.parseLong(config.getValue())))
                .createdAt(Instant.now())
                .valid(true)
                .build();

        List<OtpEntity> userOtps = repository.findByUserId(userId);
        for (OtpEntity otpEntity : userOtps) {
            otpEntity.setValid(false);
        }
        repository.saveAllAndFlush(userOtps);
        repository.saveAndFlush(otp);

        return ResponseEntity.ok(OtpResponse.builder()
                .id(otp.getId())
                .token(otp.getToken())
                .duration(config.getValue())
                .userId(otp.getUserId())
                .expiresAt(otp.getExpiresAt())
                .createdAt(otp.getCreatedAt())
                .valid(otp.getValid())
                .build());
    }

    // validação
    @GetMapping("/verify/{token}")
    public ResponseEntity<TokenValidationResult> verifyToken(@PathVariable String token,
            @RequestParam("userId") String userId) {

        OtpEntity otp = repository
                .findByTokenAndUserId(token, userId)
                .orElseThrow(() -> new RuntimeException("Token inválido ou usuário não encontrado"));

        boolean tokenInvalido = !otp.getValid();
        boolean tokenVenceu = otp.getExpiresAt().isBefore(Instant.now());
        boolean otpInvalido = tokenInvalido || tokenVenceu;

        if (otpInvalido) {
            throw new RuntimeException("Token inválido ou expirado");
        }

        otp.setValid(false);
        repository.saveAndFlush(otp);

        return ResponseEntity.ok(new TokenValidationResult(!otpInvalido));
    }
}