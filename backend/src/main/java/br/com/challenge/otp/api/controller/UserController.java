package br.com.challenge.otp.api.controller;

import java.time.Instant;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.challenge.otp.api.model.LoginInput;
import br.com.challenge.otp.api.model.LoginResponse;
import br.com.challenge.otp.api.model.UserInput;
import br.com.challenge.otp.domain.model.UserEntity;
import br.com.challenge.otp.domain.repository.UserRepository;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserRepository repository;

    @PostMapping
    public ResponseEntity<UserEntity> createUser(@RequestBody UserInput dados) {

        UserEntity user = UserEntity.builder()
                .userName(dados.getUserName())
                .email(dados.getEmail())
                .password(dados.getPassword())
                .active(true)
                .createdAt(Instant.now())
                .build();
        repository.saveAndFlush(user);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginInput dados) {
        // verificar email do usuario informado no banco de dados
        UserEntity user = repository
                .findByEmail(dados.getEmail())
                .orElse(null);

        if (Optional.ofNullable(user).isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        // verificar se a senha coincide
        boolean senhaValida = dados.getPassword().equals(user.getPassword());

        if (!senhaValida) {
            return ResponseEntity.badRequest().build();
        }

        return ResponseEntity.ok(LoginResponse.builder()
                .userId(user.getId())
                .userName(user.getUserName())
                .build());
    }
}
