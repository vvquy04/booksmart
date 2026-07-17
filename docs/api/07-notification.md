# Notification API

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Get Notification History

Retrieve the list of notifications dispatched to the authenticated user.

*   **URL**: `/notifications`
*   **Method**: `GET`
*   **Access**: Protected (`CUSTOMER`, `EMPLOYEE`, `BUSINESS_OWNER`, `ADMIN`)

### Query Parameters
*   `status`: Filter by status (`READ` or `UNREAD`, optional).
*   `page`: Page index (default 0).
*   `size`: Page capacity (default 20).

### Response (200 OK)
```json
{
  "success": true,
  "message": "Notifications fetched successfully",
  "data": {
    "content": [
      {
        "id": 102,
        "title": "Booking Confirmed",
        "content": "Your appointment BK-20260717-A89F has been confirmed for 2026-07-20 at 10:00 AM.",
        "type": "BOOKING_CONFIRMED",
        "status": "UNREAD",
        "createdAt": "2026-07-17T11:29:19Z"
      }
    ],
    "totalPages": 1,
    "totalElements": 1,
    "last": true
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:33Z"
}
```

---

# 2. Mark Notification as Read

Mark a single notification as read.

*   **URL**: `/notifications/{notificationId}/read`
*   **Method**: `PATCH`
*   **Access**: Protected (Own notification only)

---

# 3. Mark All Notifications as Read

Bulk mark all unread notifications of the user as read.

*   **URL**: `/notifications/read-all`
*   **Method**: `POST`
*   **Access**: Protected
