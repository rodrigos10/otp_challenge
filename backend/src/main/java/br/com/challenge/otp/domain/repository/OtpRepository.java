package br.com.challenge.otp.domain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.challenge.otp.domain.model.OtpEntity;

@Repository
public interface OtpRepository extends JpaRepository<OtpEntity, String> {

    Optional<OtpEntity> findByTokenAndUserId(String token, String userId);
    List<OtpEntity> findByUserId(String userId);

}
