ALTER TABLE otp_tokens
ADD CONSTRAINT fk_otp_tokens_user
FOREIGN KEY (user_id) REFERENCES user(id);
