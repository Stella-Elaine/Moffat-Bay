# Moffat Bay Lodge – Team Submission Guide

This guide shows how to package and submit so Tomcat can deploy without guesswork.

## 1. Prerequisites (Local Build Environment)
- Java JDK: 17
- Maven: 3.8+ (we used 3.9.11)
- MySQL Server: 8.0.x

## 2. Build the WAR
From project root (`Moffat-Bay/`):
```powershell
mvn clean package -DskipTests
```
Resulting artifact: `target/moffatbay.war`

## 3. Ensure Database Objects Exist
Create database and user (only needed once locally):
```sql
CREATE DATABASE IF NOT EXISTS moffat_bay CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'student'@'localhost' IDENTIFIED BY 'Student#01';
GRANT ALL PRIVILEGES ON moffat_bay.* TO 'student'@'localhost';
FLUSH PRIVILEGES;
```
Apply schema:
```powershell
# From project root
mysql -u student -pStudent#01 moffat_bay < database/schema.sql
```
If you changed the schema, update `database/schema.sql` BEFORE building the WAR. The professor relies on this file to reproduce data structures.

## 4. Verify App Locally (Optional but Recommended)
Optional local check (Tomcat 10.1.x or 11.x):
```powershell
# Copy WAR to Tomcat webapps
Copy-Item -Force target/moffatbay.war "C:\Java\apache-tomcat-10.1.48\webapps"
# Start Tomcat
& "C:\Java\apache-tomcat-10.1.48\bin\startup.bat"
```
Visit: `http://localhost:8080/moffatbay/`

## 5. ZIP Layout for Submission
Professor instructions: “Zip up all your files and put the .war in the root of the zip file.”

Required ZIP root contents (example):
```
Moffat-Bay.zip
│  moffatbay.war            <-- WAR AT ROOT (copy from target before zipping)
│  README_SUBMISSION.md     <-- (this file)
│  README_PROFESSOR.md      <-- deployment guide for professor
│  schema.sql (OPTIONAL COPY if professor requests separate) 
│
└─ Moffat-Bay/              <-- Entire project source tree
    pom.xml
    database/schema.sql
    src/...
    docs/...
```
Steps:
1. Copy `target/moffatbay.war` to ZIP root (not inside `target/`).
2. Include source directory `Moffat-Bay/`.
3. Ensure `database/schema.sql` is current.
4. Include `README_PROFESSOR.md`.

## 6. Do NOT Submit
- A WAR missing compiled classes (i.e., skipping the Maven build).
- Only the source tree without the WAR at root.
- IDE-specific build output other than Maven’s `target/moffatbay.war`.

## 7. Why WAR at root
Tomcat needs compiled classes in `WEB-INF/classes` and libs in `WEB-INF/lib`. Only the WAR (or exploded `target/moffatbay/`) has this. Submitting only source breaks servlet/DB loading.

## 8. Quick Checklist Before Zipping
- [ ] Built WAR (`mvn clean package`).
- [ ] `target/moffatbay.war` copied to ZIP root.
- [ ] `database/schema.sql` reflects latest changes.
- [ ] Include full source directory.
- [ ] Include both READMEs.

## 9. DB Health Check Servlet (Included)
Included servlet `/db-health` (`DbHealthServlet.java`) verifies JNDI and DB by running `SELECT 1`.

How to test locally after deploying the WAR:
```
http://localhost:8080/moffatbay/db-health
```
Expected success (HTTP 200):
```
STATUS: OK
QUERY: SELECT 1 -> 1
AutoCommit: true
LatencyMs: <number>
```
On failure (HTTP 500):
- Rebuild WAR (`mvn clean package`).
- Confirm MySQL user/db and credentials match `META-INF/context.xml`.
- Use Tomcat 10.1.x or later.

Include the updated WAR containing this servlet in your ZIP root.

## 10. Weekly Deliverables Checklist (Template)
For each week, include the following items in the ZIP submission per assignment requirements. Pages and features may vary by week—use this as a generic template:

- Feature pages and backend:
    - Source files under `src/main/webapp/pages/` and corresponding servlets in `src/main/java/web/`.
    - If features introduce new persistence or integrations, document configuration briefly in the README and update `database/schema.sql` accordingly.

- Test Plan: Four functional tests total (e.g., two tests per focused page or feature):
    - Document: `TestPlan_<Module>.docx` based on the provided `TestPlanTemplate.docx`.
    - Each test should clearly list: Pre-conditions, Steps, Expected Results.

- Test Execution Evidence:
    - `TestResults_<Module>.docx` with embedded screenshots (optional short videos) showing tests passing.
    - Label media to match Test Plan test IDs.

- Build Artifact:
    - `moffatbay.war` at the ZIP root (freshly built after final changes for the week).

- Database Schema:
    - `database/schema.sql` updated for any new tables/columns and aligned with the WAR.

### Suggested ZIP structure (weekly)
```
Submission_<Module>.zip
│  moffatbay.war
│  README_SUBMISSION.md
│  README_PROFESSOR.md
│  TestPlan_<Module>.docx
│  TestResults_<Module>.docx
│
└─ Moffat-Bay/
     ├─ pom.xml
     ├─ database/
     │   └─ schema.sql
     ├─ src/
     │   ├─ main/java/web/...
     │   └─ main/webapp/pages/...
     └─ docs/
            └─ (any additional design or planning docs)
```

### Pre-submission checklist
- [ ] Focused pages/features compile and render in Tomcat (10.1.x+).
- [ ] `/db-health` returns `STATUS: OK` in your environment.
- [ ] WAR rebuilt after final changes for the week and placed at ZIP root.
- [ ] `TestPlan_<Module>.docx` completed with all required tests.
- [ ] `TestResults_<Module>.docx` includes embedded screenshots/video showing tests passing.
- [ ] `database/schema.sql` reflects any updates required by this week.

---
Questions: Post in team chat before packaging.
