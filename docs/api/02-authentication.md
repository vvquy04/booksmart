# Authentication API

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Register User

Register a new customer account.

*   **URL**: `/auth/register`
*   **Method**: `POST`
*   **Access**: Public

### Request Payload
```json
{
  "email": "customer@example.com",
  "password": "SecurePassword123!",
  "fullName": "Nguyen Van A",
  "phoneNumber": "0987654321"
}
```

### Response (201 Created)
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "id": 1,
    "email": "customer@example.com",
    "fullName": "Nguyen Van A",
    "phoneNumber": "0987654321",
    "role": "CUSTOMER",
    "status": "ACTIVE"
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:09Z"
}
```

---

# 2. Login User

Authenticate user credentials and receive JWT + Refresh tokens.

*   **URL**: `/auth/login`
*   **Method**: `POST`
*   **Access**: Public

### Request Payload
```json
{
  "email": "customer@example.com",
  "password": "SecurePassword123!"
}
```

### Response (200 OK)
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsIn...",
    "refreshToken": "8f870e28-1b2c-4e89-bdc3-568e64c...",
    "tokenType": "Bearer",
    "expiresIn": 900
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:09Z"
}
```

---

# 3. Refresh Access Token

Obtain a new short-lived JWT using a valid refresh token.

*   **URL**: `/auth/refresh`
*   **Method**: `POST`
*   **Access**: Public

### Request Payload
```json
{
  "refreshToken": "8f870e28-1b2c-4e89-bdc3-568e64c..."
}
```

### Response (200 OK)
```json
{
  "success": true,
  "message": "Token refreshed successfully",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsIn...",
    "refreshToken": "7a8b3d11-89e4-4d8e-be89-724bc...",
    "tokenType": "Bearer",
    "expiresIn": 900
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:09Z"
}
```

---

# 4. Logout User

Revoke the refresh token to terminate the session.

*   **URL**: `/auth/logout`
*   **Method**: `POST`
*   **Access**: Protected (Requires Access Token)

### Request Payload
```json
{
  "refreshToken": "7a8b3d11-89e4-4d8e-be89-724bc..."
}
```

### Response (200 OK)
```json
{
  "success": true,
  "message": "Logged out successfully",
  "data": null,
  "errors": null,
  "timestamp": "2026-07-17T11:29:09Z"
}
```
