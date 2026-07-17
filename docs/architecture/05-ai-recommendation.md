# AI Recommendation Design

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. Purpose

This document outlines the architecture, mathematical heuristics, and endpoint specifications of the AI Recommendation module.

The goal of this module is to personalize and optimize search results by recommending businesses, services, and employees based on geographical, statistical, and historic feedback factors.

---

# 2. Recommendation Core Factors

The recommendation engine scores and ranks recommendations based on five key factors:

1.  **Distance ($D$)**: The physical distance in kilometers between the Customer's location and the Branch coordinates (calculated via Haversine formula). Closer branches receive higher scores.
2.  **Business Rating ($R_b$)**: The average rating of the business branch based on customer reviews.
3.  **Booking Popularity ($P_b$)**: The total count of completed bookings at the branch within the last 30 days.
4.  **Employee Rating ($R_e$)**: The specific average rating of the service provider.
5.  **Service Popularity ($P_s$)**: The booking frequency of a specific service.

---

# 3. Weighted Scoring Algorithm (Heuristics)

To calculate a recommendation score for a given business branch, the following scoring heuristic is applied:

$$Score = (W_d \times S_{distance}) + (W_r \times S_{rating}) + (W_p \times S_{popularity})$$

### Components:
*   **Weights ($W$)**: Configure the relative importance of each factor (must sum to $1.0$).
    *   $W_d$ (Distance weight) = $0.40$
    *   $W_r$ (Rating weight) = $0.35$
    *   $W_p$ (Popularity weight) = $0.25$
*   **Distance Score ($S_{distance}$)**:
    $$S_{distance} = \max\left(0, 1 - \frac{Distance}{D_{max}}\right)$$
    *(where $D_{max}$ is the maximum search radius, e.g., 20km).*
*   **Rating Score ($S_{rating}$)**:
    $$S_{rating} = \frac{AverageRating}{5.0}$$
*   **Popularity Score ($S_{popularity}$)**:
    $$S_{popularity} = \min\left(1.0, \frac{BookingCount}{P_{target}}\right)$$
    *(where $P_{target}$ is a normalization constant, e.g., 100 bookings/month).*

---

# 4. Interface Separation (Algorithm Extensibility)

To ensure the algorithmic model can be upgraded in the future (e.g., swapping heuristics for collaborative filtering or deep learning model inference) without modifying controller contracts:

*   **`RecommendationService` (Interface)**: Declares endpoints for recommendation discovery.
*   **`HeuristicRecommendationServiceImpl` (Default Implementation)**: Implements the weighted formula in Java/SQL.
*   **`MLRecommendationServiceImpl` (Future)**: Plugs in machine learning server calls (e.g., FastAPI/TensorFlow Serving endpoints) while keeping the same interface signature.

---

# 5. Recommendation Logging (`ai_recommendation_logs`)

To track the performance and click-through rate (CTR) of recommendations, the system records logs in the database.

### Log Columns
*   `id` (BIGINT, PK)
*   `user_id` (BIGINT, Nullable for guest recommendations)
*   `recommendation_type` (VARCHAR: `BUSINESS`, `SERVICE`, `EMPLOYEE`)
*   `item_id` (BIGINT, ID of the recommended entity)
*   `score` (DECIMAL(5,4), Calculated score)
*   `clicked` (BOOLEAN, Default False, updated when user taps the item)
*   `created_at` (DATETIME)

These logs provide data for future model training and offline evaluations.
