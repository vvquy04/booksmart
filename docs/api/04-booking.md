# Booking API

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Create Booking

Book one or multiple services.

*   **URL**: `/bookings`
*   **Method**: `POST`
*   **Access**: Protected (`CUSTOMER` only)

### Request Payload
```json
{
  "branchId": 1,
  "bookingDate": "2026-07-20",
  "note": "Please request a quiet room",
  "items": [
    {
      "serviceId": 1,
      "employeeId": 1,
      "startTime": "2026-07-20T10:00:00Z"
    },
    {
      "serviceId": 2,
      "employeeId": 2,
      "startTime": "2026-07-20T11:00:00Z"
    }
  ]
}
```

### Response (201 Created)
```json
{
  "success": true,
  "message": "Booking created successfully",
  "data": {
    "id": 15,
    "bookingNumber": "BK-20260717-A89F",
    "status": "CONFIRMED",
    "totalAmount": 750000.00,
    "bookingDate": "2026-07-20"
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:19Z"
}
```

---

# 2. Get Booking Details

Retrieve a specific booking.

*   **URL**: `/bookings/{bookingId}`
*   **Method**: `GET`
*   **Access**: Protected (`CUSTOMER`, `EMPLOYEE`, `BUSINESS_OWNER`, `ADMIN`)

---

# 3. Cancel Booking

Cancel a pending or confirmed booking.

*   **URL**: `/bookings/{bookingId}/cancel`
*   **Method**: `POST`
*   **Access**: Protected (`CUSTOMER`, `BUSINESS_OWNER`, `ADMIN`)

### Request Payload (Optional)
```json
{
  "reason": "Sudden meeting change"
}
```

---

# 4. Check-in Customer

Mark customer arrival at the branch.

*   **URL**: `/bookings/{bookingId}/check-in`
*   **Method**: `POST`
*   **Access**: Protected (`EMPLOYEE`, `BUSINESS_OWNER` or `CUSTOMER` with geo validation)

### Request Payload
```json
{
  "imageUrl": "https://s3.booksmart.vn/proofs/checkin-15.jpg",
  "latitude": 10.7769,
  "longitude": 106.7009
}
```

---

# 5. Complete Booking

Mark all services completed and finalize payment checks.

*   **URL**: `/bookings/{bookingId}/complete`
*   **Method**: `POST`
*   **Access**: Protected (`EMPLOYEE`, `BUSINESS_OWNER`)
