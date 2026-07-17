# Business Management API

Version: 1.1

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Register Business

Create a new business record.

*   **URL**: `/businesses`
*   **Method**: `POST`
*   **Access**: Protected (`BUSINESS_OWNER` only)

### Request Payload
```json
{
  "categoryId": 1,
  "name": "Zen Luxury Spa",
  "description": "Premium wellness and relaxation spa center",
  "phoneNumber": "0283888888",
  "email": "contact@zenspa.vn",
  "website": "https://zenspa.vn"
}
```

### Response (201 Created)
```json
{
  "success": true,
  "message": "Business registered successfully",
  "data": {
    "id": 1,
    "categoryId": 1,
    "name": "Zen Luxury Spa",
    "status": "PENDING",
    "autoConfirmBooking": false
  },
  "errors": null,
  "timestamp": "2026-07-17T11:29:14Z"
}
```

---

# 2. Get Business Categories

Fetch all active top-level categories to display on the client home page.

*   **URL**: `/business-categories`
*   **Method**: `GET`
*   **Access**: Public

### Response (200 OK)
```json
{
  "success": true,
  "message": "Business categories fetched successfully",
  "data": [
    {
      "id": 1,
      "name": "Spa & Massage",
      "slug": "spa-massage",
      "iconUrl": "https://s3.booksmart.vn/icons/spa.png"
    },
    {
      "id": 2,
      "name": "Hair Salon",
      "slug": "hair-salon",
      "iconUrl": "https://s3.booksmart.vn/icons/hair.png"
    }
  ],
  "errors": null,
  "timestamp": "2026-07-17T11:29:14Z"
}
```

---

# 3. Add Branch

Create a physical branch location for a business.

*   **URL**: `/businesses/{businessId}/branches`
*   **Method**: `POST`
*   **Access**: Protected (`BUSINESS_OWNER` only)

### Request Payload
```json
{
  "name": "Zen Spa District 1",
  "phoneNumber": "0283888881",
  "email": "d1@zenspa.vn",
  "address": "123 Le Loi, District 1, Ho Chi Minh City",
  "latitude": 10.7769,
  "longitude": 106.7009
}
```

---

# 4. Create Service

Create a service offered by the business.

*   **URL**: `/businesses/{businessId}/services`
*   **Method**: `POST`
*   **Access**: Protected (`BUSINESS_OWNER` only)

### Request Payload
```json
{
  "categoryId": 2,
  "name": "Swedish Full Body Massage",
  "description": "60 minutes Swedish full body oil relaxation therapy",
  "price": 450000.00,
  "durationMinutes": 60
}
```

---

# 5. Add Employee to Branch

Create a staff account and associate it with a branch.

*   **URL**: `/branches/{branchId}/employees`
*   **Method**: `POST`
*   **Access**: Protected (`BUSINESS_OWNER` only)

### Request Payload
```json
{
  "email": "staff.lan@zenspa.vn",
  "fullName": "Tran Thi Lan",
  "phoneNumber": "0911223344",
  "description": "5 years experienced masseuse specializing in Swedish therapy",
  "yearsOfExperience": 5,
  "serviceIds": [1, 2]
}
```

---

# 6. Discover & Search Branches

Search and filter branch locations.

*   **URL**: `/branches/search`
*   **Method**: `GET`
*   **Access**: Public

### Query Parameters
*   `query`: Search term (matches branch name, address, business name).
*   `lat`, `lon`: Coordinates for distance sorting (mandatory if filtering by radius).
*   `radiusKm`: Max distance filter in kilometers (default 10).
*   `businessCategoryId`: Filter by top-level business category ID (e.g. 1 for Spas).
*   `serviceCategoryId`: Filter by specific service menu category.
*   `page`: Page offset (default 0).
*   `size`: Page capacity (default 10).
