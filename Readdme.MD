# Online Shopping

A Dynamic Web Application built with JSP, Servlets, and JDBC, following the
MVC architecture (Controller → DAO → JSP). Customers can register, browse
products, manage a cart, and complete a simulated checkout with payment.
Admins can manage products, view registered users, and view all orders.

## Tech Stack

- **Frontend:** HTML, JSP
- **Backend:** Java Servlets (`jakarta.servlet`, Servlet 6.0), JDBC
- **Database:** MySQL
- **Server:** Apache Tomcat 10.1+ (Jakarta EE namespace)
- **IDE:** Eclipse (Dynamic Web Project)
- **Architecture:** MVC — Controller (Servlets) → DAO (JDBC) → JSP (View)

## Project Structure

```
OnlineShopping/
├── src/main/java/com/onlineshopping/
│   ├── model/        User, Product, CartItem, Order, OrderItem
│   ├── dao/           UserDAO, ProductDAO, OrderDAO (JDBC data access)
│   ├── controller/    Servlets (Register, Login, Product, Cart, Checkout,
│   │                   Payment, Admin*, AuthFilter, AdminAuthFilter)
│   └── util/          DBConnection
├── src/main/webapp/
│   ├── WEB-INF/web.xml
│   ├── *.jsp           customer-facing pages
│   ├── admin/*.jsp      admin pages
│   └── css/style.css
└── database/schema.sql
```

## Features

### Customer Module
- Register / Login / Logout (session-based)
- Browse product catalog with images, category tags, and stock levels
- Add to cart, view cart, remove items
- Checkout with order summary
- Simulated payment (card number, expiry, CVV, cardholder name)
- Order confirmation with full order summary

### Admin Module
- Secure admin login (separate from customer login)
- Add / update / delete products
- View all registered customers
- View all orders with line-item details

## Setup Instructions

### 1. Prerequisites
- JDK 11+
- Eclipse IDE for Enterprise Java Developers
- Apache Tomcat 10.1+
- MySQL Server

### 2. Import into Eclipse
- `File → New → Dynamic Web Project`, target runtime = Tomcat 10.1,
  Dynamic Web Module version 6.0.
- Place source files under `src/main/java` and web files under
  `src/main/webapp` as shown in the structure above.

### 3. Add the MySQL JDBC driver
- Download `mysql-connector-j-<version>.jar` from
  https://dev.mysql.com/downloads/connector/j/
- Copy it into `src/main/webapp/WEB-INF/lib/`.

### 4. Create the database
- Run `database/schema.sql` in MySQL (creates `online_shopping_db`,
  all tables, a default admin account, and 5 sample products).

### 5. Configure the DB connection
- Open `src/main/java/com/onlineshopping/util/DBConnection.java`.
- Update `USER` and `PASSWORD` to match your MySQL credentials.
- The URL already includes `allowPublicKeyRetrieval=true` for MySQL 8+
  compatibility with the `caching_sha2_password` auth plugin.

### 6. Run on Tomcat
- Right-click project → `Run As → Run on Server` → select Tomcat 10.1.
- Visit `http://localhost:8080/OnlineShopping/`.

## Default Logins

- **Admin:** username `ad`, password `ad`
- **Customer:** register a new account from the site.

## Notes

- **Cart storage:** the cart lives in `HttpSession`, not the database —
  standard practice for shopping carts, and it clears automatically on
  logout since session invalidation wipes all session attributes.
- **Payment:** simulated only. Card number and CVV are validated for
  format but never contact a real gateway and are never persisted — only
  the cardholder name and **last 4 digits** of the card are saved with
  each order.
- **Product images:** `image_path` stores a direct image URL (e.g. from
  Unsplash or any public image host), not an uploaded file — kept simple
  for this project rather than implementing file upload handling.
- **Access control:** two servlet filters enforce login requirements —
  `AuthFilter` for customer-only pages (`/cart`, `/checkout`, `/payment`,
  etc.) and `AdminAuthFilter` for everything under `/admin/*`. Both check
  `HttpSession` and redirect to the appropriate login page if absent.
- **Known simplification:** passwords are stored and compared in plain
  text for simplicity. In a production system these would be hashed
  (e.g. with BCrypt) and never stored or compared as plain text.