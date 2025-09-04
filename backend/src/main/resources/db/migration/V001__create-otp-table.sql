CREATE TABLE
    otp_tokens (
        id CHAR(36) NOT NULL,
        token VARCHAR(10) NOT NULL,
        user_id CHAR(36) NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        expires_at TIMESTAMP NOT NULL,
        is_valid BOOLEAN NOT NULL DEFAULT TRUE,
        PRIMARY KEY (id)
    );