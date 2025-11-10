# Database setup (MySQL 8.0.43)

# mysql -u root -p moffat_bay < database/seeds.sql
# README — Local MySQL Setup & Schema Load (for Moffat Bay devs/interns)


DATABASE: 
| **Username**      | `student`    |
| **Password**      | `Student#01` |
| **Database name** | `moffat_bay` |


To work inside the DB you need to locally run MyMQL 
HERe is a step by step command review to ensure, one, you have MYSQL installed on your computer, and two, to start it to run the DB 

Below is what I did and then more traditonal readme if these don't work. 

0. MAKE SURE You CLONE the REPO 

1. CD into the repo MOFFAT_BAY 

2. at the "root" or "main" inside the MOFFAT_BAY repo, type in `which mysql` 
ex: 
`stella@SEsMac Moffat-Bay % which mysql`
should see something like this: 

`/opt/homebrew/bin/mysql`


3. `mysql --version`
ex: 
`stella@SEsMac Moffat-Bay % mysql --version`

`mysql  Ver 9.4.0 for macos15.4 on arm64 (Homebrew)`

IF you have the correct version for MySQL then start the service:
Log into the DB

4. `brew services start mysql`

useing `brew services restart mysql` will start/restart.


5. type in :
 `mysql -u root -p < database/schema.sql`

 You will prompted to enter the password above after this
EX: 
stella@SEsMac Moffat-Bay % mysql -u root -p < database/schema.sql
Enter password: 

6. 


`mysql -u root -p -e "SHOW TABLES;" moffat_bay`

7. 


`mysql -u root -p -e "SELECT * FROM room_types;" moffat_bay`


 
Traditional: 
00. OVERVIEW 
- We use **MySQL 8.0.43** locally.
- We build with **Maven** and deploy a WAR to Tomcat in later steps.
- The **DB app user** is `student` with password `Student#01`.
- You must first log in as **root** to create the database and the `student` user.

1. — Verify MySQL is running

Depending on what computer you have here are the commands to check 
### macOS (Homebrew)
```bash
which mysql
mysql --version
brew services list | grep -i mysql
brew services start mysql
```

### Windows
```powershell
sc query MySQL80
net start MySQL80
```

### Linux
```bash
which mysql
mysql --version
sudo systemctl status mysql
sudo systemctl start mysql
```


 2. — Try simple root logins
```bash
mysql -u root
mysql -u root -p
```

If you get in:
```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'StrongRootPass123!';
FLUSH PRIVILEGES;
EXIT;
```

If you cannot log in as root or your local root is not set up, go to Step 3.

 3. — Reset the root password

### macOS (Homebrew)
In the terminal 
```bash 
brew services stop mysql
/opt/homebrew/opt/mysql/bin/mysqld_safe --skip-grant-tables --skip-networking &
mysql -u root
```


```sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'StrongRootPass123!';
FLUSH PRIVILEGES;
EXIT;
```

```bash
brew services start mysql
```

### Windows
```powershell
net stop MySQL80
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --skip-grant-tables --skip-networking
mysql -u root
```
```sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'StrongRootPass123!';
FLUSH PRIVILEGES;
EXIT;
```
```powershell
net start MySQL80
```

### Linux
```bash
sudo systemctl stop mysql
sudo mysqld_safe --skip-grant-tables --skip-networking &
mysql -u root
```
```sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'StrongRootPass123!';
FLUSH PRIVILEGES;
EXIT;
```
```bash
sudo systemctl start mysql
```

---

 4. — Run the schema
```bash
mysql -u root -p < database/schema.sql
```

---

 5. — Verify the database and seed data
```bash
mysql -u root -p -e "SHOW DATABASES;"
mysql -u root -p -e "SHOW TABLES;" moffat_bay
mysql -u root -p -e "SELECT * FROM room_types;" moffat_bay
```

6. Test the app user directly: in the terminal ( not in mysql look for the terminal to say bash)
`mysql -u student -pStudent#01 moffat_bay -e "SELECT COUNT(*) FROM room_types;`


## FAQ

**Q: Why do I need a root password if the professor gave me `student` / `Student#01`?**  
A: `root` is the local admin account used to create the DB and `student` user. The app uses `student` / `Student#01` later.

**Q: Where do I put DB creds for Tomcat?**  
A: Inside `src/main/webapp/META-INF/context.xml` using a JNDI resource.

**Q: Is it safe to use `-pYourPassword` inline?**  
A: No. Always use `-p` and type the password when prompted.

---

**Success Criteria**
- `SHOW TABLES;` returns: `customers`, `room_types`, `rooms`, `reservations`, `reservation_rooms`
- `SELECT * FROM room_types;` returns 4 seeded room types.
- App user (`student` / `Student#01`) connects successfully.



