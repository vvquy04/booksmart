# Payment API

Version: 1.1

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Initiate Payment Transaction

Generate a payment gateway checkout URL for a booking.

*   **URL**: `/payments/checkout`
*   **Method**: `POST`
*   **Access**: Protected (`CUSTOMER` only)

### Request Payload
```json
{
  "bookingId": 15,
  "paymentMethod": "VNPAY"
}
```

### Response (200 OK)
```json
{
  "success": true,
  "message": "Payment checkout initiated",
  "data": {
    "paymentId": 45,
    "bookingId": 15,
    "amount": 750000.00,
    "checkoutUrl": "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=75000000..."
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:24Z"
}
```

---

# 2. VNPay Webhook Callback

Secure IPN (Instant Payment Notification) called by VNPay server upon user checkout completion.

*   **URL**: `/payments/vnpay-ipn`
*   **Method**: `GET`
*   **Access**: Public (Requires IPN IP verification and signature verification)

### Key Query Parameters
*   `vnp_Amount`: Transaction amount.
*   `vnp_ResponseCode`: `00` for success.
*   `vnp_TxnRef`: System payment transaction ID.
*   `vnp_SecureHash`: SHA256 signature to verify message origin.

### Response (200 OK)
```json
{
  "RspCode": "00",
  "Message": "Confirm success"
}
```

---

# 3. MoMo Webhook IPN

Callback called by MoMo transaction server upon payment completion.

*   **URL**: `/payments/momo-ipn`
*   **Method**: `POST`
*   **Access**: Public (Requires checksum validation)

### Request Payload
```json
{
  "partnerCode": "MOMO",
  "orderId": "BK-20260717-A89F",
  "requestId": "req-15-20260717",
  "amount": 750000,
  "resultCode": 0,
  "signature": "ab76cd23ef890a..."
}
```

---

# 4. Request Refund

Initiate a refund for a paid booking cancellation (e.g., if cancelled within the allowed window).

*   **URL**: `/payments/{paymentId}/refund`
*   **Method**: `POST`
*   **Access**: Protected (`BUSINESS_OWNER`, `ADMIN`)

### Request Payload
```json
{
  "amount": 750000.00,
  "reason": "Customer request cancel within 24h window"
}
```

### Response (200 OK)
```json
{
  "success": true,
  "message": "Refund processed successfully",
  "data": {
    "refundId": 12,
    "paymentId": 45,
    "refundTransactionNo": "REF-VNP-20260717-89C3",
    "amount": 750000.00,
    "status": "SUCCESS"
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:24Z"
}
```
