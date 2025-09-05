package br.com.challenge.otp.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.challenge.otp.domain.model.ConfigEntity;
import br.com.challenge.otp.domain.repository.ConfigRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/config")
public class ConfigController {

    @Autowired
    private ConfigRepository repository;

    @GetMapping("/{configName}")
    public ResponseEntity<ConfigEntity> getConfig(@PathVariable("configName") String configName) {
        ConfigEntity config = repository
                .findByConfigName(configName)
                .orElseThrow(() -> new RuntimeException("Configuração " + configName + " não encontrada"));

        return ResponseEntity.ok(config);
    }

}