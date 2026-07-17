# Authentication Database Design

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document describes the database design of the Authentication module.

---

# 2. Tables

- roles
- users
- refresh_tokens

---

# 3. Table: roles

## Description

Stores all system roles.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| name | VARCHAR(50) | UNIQUE |
| description | VARCHAR(255) | NULL |
| created_at | DATETIME | NOT NULL |
| updated_at | DATETIME | NOT NULL |

### Default Data

| Name |
|------|
| ADMIN |
| BUSINESS_OWNER |
| EMPLOYEE |
| CUSTOMER |

---

# 4. Table: users

## Description

Stores authentication and profile information.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| role_id | BIGINT | FK → roles.id |
| email | VARCHAR(255) | UNIQUE |
| password | VARCHAR(255) | NOT NULL |
| full_name | VARCHAR(255) | NOT NULL |
| phone_number | VARCHAR(20) | NULL |
| avatar_url | VARCHAR(500) | NULL |
| status | VARCHAR(20) | ACTIVE, INACTIVE, BLOCKED |
| email_verified | BOOLEAN | DEFAULT FALSE |
| created_at | DATETIME | NOT NULL |
| updated_at | DATETIME | NOT NULL |
| deleted_at | DATETIME | NULL |

---

# 5. Table: refresh_tokens

## Description

Stores refresh tokens for JWT authentication.

### Columns

| Column | Type | Constraint |
|---------|------|------------|
| id | BIGINT | PK |
| user_id | BIGINT | FK → users.id |
| token | VARCHAR(512) | UNIQUE |
| expired_at | DATETIME | NOT NULL |
| revoked | BOOLEAN | DEFAULT FALSE |
| created_at | DATETIME | NOT NULL |

---

# 6. Relationships

roles

1 ------ N users

users

1 ------ N refresh_tokens

---

# 7. Constraints

- Email must be unique.
- Role is mandatory.
- Password must be encrypted.
- Deleted users cannot log in.
- Revoked refresh tokens cannot be reused.

---

# 8. Indexes

roles

- UK(name)

users

- UK(email)
- IDX(role_id)

refresh_tokens

- UK(token)
- IDX(user_id)

---

# 9. Future Improvements

- OAuth Account
- Social Login
- Two-Factor Authentication
- Device Management
- Login History