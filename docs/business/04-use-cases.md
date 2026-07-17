# Use Cases

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document details the primary use cases for the BookSmart platform. It describes the interaction between system actors and the application for key business workflows.

---

# 2. Actors

The system defines four main actors:

*   **Customer**: An end-user who searches for businesses, books appointments, and makes online payments.
*   **Business Owner**: A business partner who registers their business, manages branches, manages employees, configures services, and views business dashboards.
*   **Employee**: A service provider hired by a business who views assigned bookings, checks in customers, and completes services.
*   **Administrator**: A platform administrator who verifies businesses, suspends accounts, monitors system activities, and handles reports.

---

# 3. Use Case Summaries

```mermaid
left-to-right-direction
actor Customer as "Customer"
actor Owner as "Business Owner"
actor Employee as "Employee"
actor Admin as "Administrator"

rectangle "BookSmart Core System" {
  usecase UC1 as "Browse/Search Services & Businesses"
  usecase UC2 as "Book Appointment"
  usecase UC3 as "Make Online Payment"
  usecase UC4 as "Check-in at Branch"
  usecase UC5 as "Review Service/Employee"
  
  usecase UC6 as "Manage Business & Branches"
  usecase UC7 as "Manage Employees & Schedules"
  usecase UC8 as "Configure Services & Working Hours"
  usecase UC9 as "View Performance Dashboard"
  
  usecase UC10 as "View Assigned Schedule"
  usecase UC11 as "Update Booking Status"
  
  usecase UC12 as "Verify & Audit Business"
  usecase UC13 as "Manage Platform Users"
}

Customer --> UC1
Customer --> UC2
Customer --> UC3
Customer --> UC4
Customer --> UC5

Owner --> UC6
Owner --> UC7
Owner --> UC8
Owner --> UC9

Employee --> UC10
Employee --> UC11
Employee --> UC4

Admin --> UC12
Admin --> UC13
```

---

# 4. Detailed Use Case Flows

## UC-01: Book Appointment (Customer)

### Description
A Customer books one or multiple services at a specific branch for a selected date and time slot.

### Preconditions
*   Customer is registered and logged into the system.
*   The business and branch are active and verified.

### Main Flow
1.  **Search**: Customer searches for a business/branch or service.
2.  **Select Branch**: Customer selects a specific branch.
3.  **Select Services**: Customer selects one or multiple services offered by the branch.
4.  **Select Employee**: Customer optionally selects an employee for each service (or chooses "Any Available").
5.  **Select Date & Time**: Customer chooses an available date and time slot from the schedule.
6.  **Confirm Booking**: Customer reviews the booking summary (services, prices, duration, timeslot) and clicks "Book".
7.  **Hold Slot**: The system temporarily locks the selected slot and prompts for payment if required by the branch's policy.
8.  **Complete Booking**: Upon successful booking (or payment), the system updates the booking status to `CONFIRMED` (or `PENDING` if manual confirmation is needed) and sends a notification to the customer and the business.

---

## UC-02: Check-in at Branch (Customer & Employee)

### Description
A customer arrives at the branch and checks in for their scheduled appointment.

### Preconditions
*   The booking status is `CONFIRMED`.
*   The current time is within the allowed check-in window (e.g., 15 minutes before to 15 minutes after start time).

### Main Flow
1.  **Arrive & Present**: The customer arrives at the branch and opens the mobile app.
2.  **Scan/Upload**: Customer triggers "Online Check-In" and uploads a photo or scans a location QR code at the desk.
3.  **Alternative Verification**: Alternatively, the Employee checks in the customer via the employee dashboard.
4.  **Update Status**: The system verifies the timeslot, matches the booking, updates the status to `CHECKED_IN`, and records the check-in time.
5.  **Notify Employee**: The system alerts the assigned employee that the customer has arrived.

---

## UC-03: Complete Service & Mark Booking (Employee)

### Description
An employee finishes performing the scheduled services and completes the booking.

### Preconditions
*   Booking is in `CHECKED_IN` status.

### Main Flow
1.  **Service Delivery**: The Employee provides the booked service(s).
2.  **Update Progress**: The Employee updates the booking item status as they proceed.
3.  **Finalize**: Once all service items are performed, the Employee marks the booking as `COMPLETED`.
4.  **Process Payment**: If there is any unpaid balance (e.g., cash payment), the employee records the payment.
5.  **Trigger Review Option**: The system updates the booking status to `COMPLETED`, records the completion time, and sends a notification to the customer inviting them to review the service.

---

## UC-04: Verify Business (Administrator)

### Description
An administrator reviews and verifies a newly registered business to allow it to receive bookings.

### Preconditions
*   A Business Owner has registered a business and uploaded required documentation.
*   Business status is `PENDING`.

### Main Flow
1.  **Submit Request**: The Business Owner registers a business and submits documentation.
2.  **Audit**: The Administrator reviews the registration details and business licenses.
3.  **Approve**: The Administrator selects "Verify Business".
4.  **Activation**: The system updates the business status to `VERIFIED` and activates the business's public profile.
5.  **Notification**: The system sends an email/push notification to the Business Owner.

---

# 5. Exception Flows

### EF-01: Double Booking Conflict
*   If two customers attempt to book the same slot for the same employee at the exact same time, the system commits the first request.
*   The second request fails during the "Hold Slot" stage.
*   The system displays an error message stating "The selected time slot is no longer available" and prompts the user to select another slot.

### EF-02: Late Check-in / No Show
*   If the check-in time window expires and the customer has not checked in:
    *   The system automatically triggers a background cron job.
    *   The booking status is updated to `NO_SHOW`.
    *   The locked timeslots are released back into the pool.
    *   If a cancellation policy is configured, the system processes penalties or notifies the owner.
