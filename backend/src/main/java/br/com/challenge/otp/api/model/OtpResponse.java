package br.com.challenge.otp.api.model;

import java.time.Instant;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OtpResponse {
    private String id;
    private String token;
    private String duration;
    private String userId;
    private Instant expiresAt;
    private Instant createdAt;
    private Boolean valid;

}
