CREATE TABLE refresh_tokens (
                                id BIGINT AUTO_INCREMENT PRIMARY KEY,

                                user_id BIGINT NOT NULL,

                                token VARCHAR(512) NOT NULL,

                                expired_at DATETIME NOT NULL,

                                revoked BOOLEAN NOT NULL DEFAULT FALSE,

                                created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

                                CONSTRAINT fk_refresh_tokens_user
                                    FOREIGN KEY (user_id)
                                        REFERENCES users(id),

                                CONSTRAINT uk_refresh_tokens_token
                                    UNIQUE (token)
);

CREATE INDEX idx_refresh_tokens_user
    ON refresh_tokens(user_id);