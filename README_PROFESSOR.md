# Moffat Bay Lodge – Deployment & Testing Guide (Professor)

Thank you for reviewing our project. This README provides concise steps to deploy and test the application in your Tomcat/MySQL environment.

## 1. Environment Assumptions
- Tomcat: 10.1.48 (Jakarta Servlet 6.0) – matches our `jakarta.servlet` imports.
- Java: JDK 17
- MySQL: 8.0.43

## 2. Provided Artifacts
You should see:
- `moffatbay.war` (at ZIP root per instructions)
- Project source directory `Moffat-Bay/` (includes `pom.xml` and `database/schema.sql`)

## 3. Database Setup
Create database and user (if not already present):
```sql
CREATE DATABASE IF NOT EXISTS moffat_bay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'student'@'localhost' IDENTIFIED BY 'Student#01';
GRANT ALL PRIVILEGES ON moffat_bay.* TO 'student'@'localhost';
FLUSH PRIVILEGES;
```
Apply schema:
```bash
mysql -u student -pStudent#01 moffat_bay < database/schema.sql
```
(If the WAR is extracted elsewhere, adjust path to `schema.sql` accordingly.)

## 4. Deploying the Application
1. Copy `moffatbay.war` into Tomcat's `webapps/` directory.
2. Start (or restart) Tomcat:
   - Windows: `bin\startup.bat`
   - Linux/macOS: `bin/startup.sh`
3. Tomcat will expand WAR to `webapps/moffatbay/`.

Access the site:
```
http://localhost:8080/moffatbay/
```

## 5. Application Structure (Inside WAR)
- `WEB-INF/classes/` – compiled Java classes (`dao`, `db`, `model`, `web`)
- `WEB-INF/lib/` – third-party dependencies (JSTL, MySQL connector, BCrypt, etc.)
- `META-INF/context.xml` – JNDI Resource for `jdbc/MoffatBayDS`
- `WEB-INF/web.xml` – resource-ref + welcome file

## 6. DataSource / JNDI Details
Lookup code uses:
```
java:comp/env/jdbc/MoffatBayDS
```
`context.xml` resource definition:
```xml
<Resource
  name="jdbc/MoffatBayDS"
  auth="Container"
  type="javax.sql.DataSource"
  maxTotal="50"
  maxIdle="10"
  maxWaitMillis="10000"
  username="student"
  password="Student#01"
  driverClassName="com.mysql.cj.jdbc.Driver"
  url="jdbc:mysql://localhost:3306/moffat_bay?useSSL=false&amp;allowPublicKeyRetrieval=true&amp;serverTimezone=UTC"/>
```
No manual change should be needed if MySQL runs on localhost.

## 7. Testing Flow Suggestions
1. Registration: `pages/register.jsp` – create a user; expect success message.
2. Login: `pages/login.jsp` – authenticate; redirects to `pages/reservation.jsp`.
3. Make Reservation: Use form to search and reserve rooms.
4. Summary Page: Confirm reservation details at `/reservation-summary?id=<ID>`.
5. Lookup: `pages/lookup.jsp` – query by reservation ID or email.
6. Cancellation: Use provided cancel functionality (if exposed) to test transactional rollback on room release.

## 8. Common Failure Modes (If Something Breaks)
| Symptom | Likely Cause | Resolution |
|---------|--------------|-----------|
| `ClassNotFoundException` for servlets/DAO | Deployed source folder instead of WAR | Ensure WAR deployed to `webapps/` |
| JNDI lookup failure (`ExceptionInInitializerError` from `Db`) | Resource not loaded (context.xml omitted) | Verify `context.xml` resides at `META-INF/` in WAR |
| Cannot connect to DB | User/database missing or password changed | Re-run SQL setup commands |
| JSTL tags error | JSTL libs missing | Confirm WAR `WEB-INF/lib` contains JSTL JARs |
| 404 for `pages/*.jsp` | Wrong context path or missing expansion | Check exploded folder `webapps/moffatbay/pages/` |

## 9. DB Health Endpoint
Included servlet: `DbHealthServlet` mapped to `/db-health`.

Usage:
```
GET /moffatbay/db-health
```
Successful response (HTTP 200) shows:
```
STATUS: OK
QUERY: SELECT 1 -> 1
AutoCommit: true
LatencyMs: <number>
```
Failure returns HTTP 500 with error details.

Purpose: Quick verification that JNDI DataSource binds and a simple query executes against MySQL.

## 10. Rebuilding (If Needed)
If you decide to rebuild from source:
```bash
cd Moffat-Bay
mvn clean package -DskipTests
# New WAR at target/moffatbay.war
```
(Requires JDK 17 + Maven.)

## 11. Notes on Compatibility
- Uses `jakarta.servlet` (Servlet 6.0) – Tomcat 10.1.x fully supports this.
- `javax.naming` / `javax.sql` usage is correct (still in Java SE).
- MySQL driver 8.4.0 works with server 8.0.43.

## 12. Contact / Clarifications
If anything fails unexpectedly, please let us know which step and stack trace so we can reproduce. We can add further diagnostics if requested, but `/db-health` should offer initial insight.

---
Thank you for your time reviewing our work.
