CREATE TABLE
    user (
        id CHAR(36) NOT NULL,
        user_name VARCHAR(100) NOT NULL,
        email CHAR(100) NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        is_active BOOLEAN NOT NULL DEFAULT TRUE,
        PRIMARY KEY (id)
    );