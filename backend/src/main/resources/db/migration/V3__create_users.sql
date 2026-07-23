CREATE TABLE users (
                       id BIGINT AUTO_INCREMENT PRIMARY KEY,

                       role_id BIGINT NOT NULL,

                       email VARCHAR(255) NOT NULL,
                       password VARCHAR(255) NOT NULL,

                       full_name VARCHAR(255) NOT NULL,

                       phone_number VARCHAR(20),

                       avatar_url VARCHAR(500),

                       status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

                       email_verified BOOLEAN NOT NULL DEFAULT FALSE,

                       created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

                       updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                           ON UPDATE CURRENT_TIMESTAMP,

                       deleted_at DATETIME NULL,

                       CONSTRAINT fk_users_role
                           FOREIGN KEY (role_id)
                               REFERENCES roles(id),

                       CONSTRAINT uk_users_email
                           UNIQUE (email)
);

CREATE INDEX idx_users_role
    ON users(role_id);