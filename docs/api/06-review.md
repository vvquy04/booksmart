# Review API

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Submit Review

Write a review and assign rating stars to a completed booking transaction.

*   **URL**: `/reviews`
*   **Method**: `POST`
*   **Access**: Protected (`CUSTOMER` only)

### Request Payload
```json
{
  "bookingId": 15,
  "businessId": 1,
  "employeeId": 1,
  "serviceId": 1,
  "rating": 5,
  "comment": "Excellent massage! Tran Thi Lan was very professional and the room was incredibly soothing."
}
```

### Response (201 Created)
```json
{
  "success": true,
  "message": "Review submitted successfully",
  "data": {
    "id": 8,
    "rating": 5,
    "comment": "Excellent massage!...",
    "createdAt": "2026-07-17T11:29:28Z"
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:28Z"
}
```

---

# 2. Get Reviews for Business Branch

List customer reviews for a business branch.

*   **URL**: `/reviews/branches/{branchId}`
*   **Method**: `GET`
*   **Access**: Public

### Query Parameters
*   `page`: Page offset (default 0).
*   `size`: Page capacity (default 10).

---

# 3. Get Reviews for Employee

Retrieve ratings and written comments for a specific service provider.

*   **URL**: `/reviews/employees/{employeeId}`
*   **Method**: `GET`
*   **Access**: Public

---

# 4. Delete Review

Remove a review from the database.

*   **URL**: `/reviews/{reviewId}`
*   **Method**: `DELETE`
*   **Access**: Protected (`CUSTOMER` (own reviews), `ADMIN`)
