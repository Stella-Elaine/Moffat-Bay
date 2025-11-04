# Database setup (MySQL 8.0.43)

```bash
mysql -u root -p < database/schema.sql
# (Optional) later refresh test data
# mysql -u root -p moffat_bay < database/seeds.sql
