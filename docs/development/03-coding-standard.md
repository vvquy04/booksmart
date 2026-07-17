# Coding Standards

Version: 1.0

Status: Approved

Author: Vi Quy

Reviewer: ChatGPT (Tech Lead)

---

# 1. General Java Conventions

*   **Style Guide**: Adhere strictly to the **Google Java Style Guide**.
*   **Java Version**: Leverage Java 21 features (pattern matching, records, text blocks) where applicable.
*   **Naming Conventions**:
    *   Classes, Interfaces, Enums: `PascalCase` (e.g. `BookingService`).
    *   Variables, Methods: `camelCase` (e.g. `createBooking`).
    *   Constants: `UPPER_SNAKE_CASE` (e.g. `MAX_DISTANCE_KM`).
    *   Packages: lowercase, singular nouns (e.g. `com.booksmart.booking`).

---

# 2. Lombok Guidelines

Lombok reduces boilerplate, but improper usage can break Hibernate tracking or trigger recursive stack overflows.

### Best Practices:
*   **Entities**:
    *   Do **NOT** use `@Data` on JPA Entities. It implicitly creates `@ToString` and `@EqualsAndHashCode` containing all fields, which triggers circular references in bidirectional associations.
    *   Use `@Getter`, `@Setter`, `@NoArgsConstructor`, `@AllArgsConstructor` explicitly.
    *   Always override `equals()` and `hashCode()` to compare entities based on their natural business key or immutable ID (rather than standard JPA proxies).
*   **DTOs**:
    *   Use `@Value` (immutable records) or `@Getter`, `@Builder`, `@NoArgsConstructor`, `@AllArgsConstructor` for mutable payload wrappers.

---

# 3. MapStruct Mapping Standards

*   Define converters as interfaces marked with `@Mapper(componentModel = "spring")`.
*   Ensure all conversions between DTOs and entities pass through these MapStruct interfaces to avoid manual builders cluttering service methods.
*   Explicitly map mismatching field names using `@Mapping(target = "...", source = "...")`.

---

# 4. Clean Code & Architectural Rules

### Small, Focused Classes
*   Keep controllers thin. Controllers must only parse and validate requests, call the service layer, and return standard response wrappers.
*   Services should execute one primary concern. If a service becomes too large, refactor helpers or sub-components.

### DRY (Don't Repeat Yourself)
*   Encapsulate shared structures (e.g. standard pagination calculations, auditing listeners, soft delete properties) in the `com.booksmart.common` module.

### Dependency Injection
*   Always prefer constructor-based injection over field-based injection (`@Autowired` on variables). Constructor injection guarantees testability and immutability.
    *   Use Lombok's `@RequiredArgsConstructor` on classes to automatically generate constructor injection boilerplate.
