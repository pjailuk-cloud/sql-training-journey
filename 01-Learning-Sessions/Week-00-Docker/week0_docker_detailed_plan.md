# 🐳 สัปดาห์ 0: Docker Quick Start - รายละเอียด 3 วัน

**📅 วันที่**: 11-13 กันยายน 2568  
**🎯 เป้าหมาย**: พร้อมใช้ PostgreSQL Container สำหรับการเรียน SQL  
**⏰ เวลา**: วันละ 2 ชั่วโมง (4 ช่วง x 25 นาที + พัก 5 นาที)

---

## 🚀 **วันที่ 1: Docker Foundation** (11 กันยายน 2568)

### 📋 **Pre-Session Preparation**
- [ ] เปิด GitHub Desktop, สร้าง repository: `sql-training-journey`
- [ ] เปิด Claude Code, ทดสอบการเชื่อมต่อ
- [ ] เตรียม Notebook สำหรับ Visual Learning (ตามที่คุณชอบ)

---

### ⏰ **ช่วงที่ 1 (25 นาที): Docker Concepts & Installation**

#### 🎯 Learning Objectives
- เข้าใจ Docker Architecture และประโยชน์สำหรับ Data Engineer
- ติดตั้ง Docker Desktop บน Windows 11

#### 📚 เนื้อหา
**Docker คืออะไร? (10 นาที)**
- **Containerization vs Virtual Machine**: 
  ```
  Virtual Machine: OS → Hypervisor → Guest OS → App
  Docker Container: OS → Docker Engine → Container → App
  ```
- **ประโยชน์สำหรับ Data Engineer**:
  - Environment consistency (Dev = Prod)
  - Resource efficiency (ใช้ RAM น้อยกว่า VM)
  - Portable (ย้ายข้าม environments ได้)
  - Version control สำหรับ infrastructure

**Docker Architecture (5 นาที)**
```
[Developer] → [Docker Client] → [Docker Daemon] → [Images] → [Containers]
     ↓                ↓                    ↓
  [Commands]    [Docker Desktop]    [PostgreSQL Image]
```

**Installation Steps (10 นาที)**
1. ดาวน์โหลด Docker Desktop จาก https://www.docker.com/products/docker-desktop
2. Run installer → Enable WSL 2 integration
3. Restart Windows
4. เปิด Docker Desktop → Wait for "Docker Desktop is running"
5. เปิด PowerShell/Command Prompt, test: `docker --version`

#### 🛠️ Hands-on Activity
```bash
# ทดสอบ Docker installation
docker --version
docker run hello-world

# ตรวจสอบ system resources
docker system info
```

**Expected Output**: `Hello from Docker!` message

---

### 🔄 **พัก 5 นาที** ☕

---

### ⏰ **ช่วงที่ 2 (25 นาที): Docker Basic Commands**

#### 🎯 Learning Objectives
- เข้าใจ Images vs Containers concept
- ใช้คำสั่ง Docker พื้นฐานได้

#### 📚 เนื้อหา
**Images vs Containers (5 นาที)**
```
Docker Image = Blueprint (แบบแปลน)
Container = Running Instance (บ้านที่สร้างจาก blueprint)

เปรียบเทียบ:
Image : Container = Class : Object (ใน OOP)
```

**Essential Commands (20 นาที)**
```bash
# 1. ค้นหา Images
docker search postgres

# 2. ดาวน์โหลด Image
docker pull postgres:15
docker pull hello-world

# 3. ดู Images ที่มี
docker images

# 4. Run Container
docker run --name test-container hello-world

# 5. ดู Containers
docker ps           # Running containers
docker ps -a        # All containers (including stopped)

# 6. จัดการ Containers
docker stop test-container
docker start test-container
docker rm test-container    # ลบ container
docker rmi hello-world      # ลบ image
```

#### 🛠️ Hands-on Activity
```bash
# Practice session
docker pull nginx:latest
docker run --name web-test -p 8080:80 -d nginx
# เปิด browser → http://localhost:8080 (ควรเห็น Nginx welcome page)
docker stop web-test
docker rm web-test
docker rmi nginx
```

#### 📝 **GitHub Activity**: สร้าง first commit
```bash
# ใน repository sql-training-journey
mkdir week0-docker
cd week0-docker
echo "# Docker Learning Journey - Week 0" > README.md
echo "## Day 1: Docker Foundation" >> README.md
echo "- Learned Docker basics" >> README.md
echo "- Installed Docker Desktop" >> README.md
echo "- Practiced basic commands" >> README.md

# Commit ด้วย GitHub Desktop
```

---

### 🔄 **พัก 5 นาที** ☕

---

### ⏰ **ช่วงที่ 3 (25 นาที): PostgreSQL Container - First Setup**

#### 🎯 Learning Objectives
- Run PostgreSQL container ครั้งแรก
- เข้าใจ Environment Variables และ Port Mapping

#### 📚 เนื้อหา
**PostgreSQL Docker Setup Concepts (10 นาที)**
- **Environment Variables**: การกำหนดค่า database
  ```bash
  POSTGRES_DB=training        # ชื่อ database
  POSTGRES_USER=student       # username
  POSTGRES_PASSWORD=pass123   # password
  ```
- **Port Mapping**: `-p host_port:container_port`
  ```bash
  -p 5432:5432  # map port 5432 ของเครื่องไปยัง container
  ```
- **Volume Mounting**: เก็บข้อมูลไม่ให้หาย
  ```bash
  -v postgres_data:/var/lib/postgresql/data
  ```

**PostgreSQL Container Setup (15 นาที)**
```bash
# สร้าง PostgreSQL container
docker run --name postgres-sql-training \
  -e POSTGRES_DB=training \
  -e POSTGRES_USER=student \
  -e POSTGRES_PASSWORD=securepass123 \
  -p 5432:5432 \
  -d postgres:15

# ตรวจสอบ status
docker ps

# ดู logs
docker logs postgres-sql-training

# ทดสอบเข้าใช้ database
docker exec -it postgres-sql-training psql -U student -d training
```

#### 🛠️ Hands-on Activity
```sql
-- ภายใน PostgreSQL container
-- ทดสอบ SQL commands
SELECT version();
SELECT current_database();
SELECT current_user;

-- สร้าง table ทดสอบ
CREATE TABLE test_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert ข้อมูลทดสอบ
INSERT INTO test_table (name) VALUES ('Docker Test');
SELECT * FROM test_table;

-- ออกจาก psql
\q
```

---

### 🔄 **พัก 5 นาที** ☕

---

### ⏰ **ช่วงที่ 4 (25 นาที): Troubleshooting & Documentation**

#### 🎯 Learning Objectives
- แก้ปัญหาที่พบบ่อย
- บันทึกการเรียนรู้และ setup instructions

#### 🐛 **Common Issues & Solutions**
```bash
# Issue 1: Port already in use
# Solution: หา process ที่ใช้ port 5432
netstat -an | findstr 5432
# หรือเปลี่ยน port
docker run -p 5433:5432 ...

# Issue 2: Container name already exists
# Solution: ลบ container เก่า
docker rm postgres-sql-training
# หรือใช้ชื่อใหม่

# Issue 3: Permission denied
# Solution: Run Docker Desktop as Administrator

# Issue 4: Container stops immediately
# Solution: ตรวจสอบ logs
docker logs postgres-sql-training
```

#### 📝 **Documentation Practice**
สร้างไฟล์ `docker-setup-guide.md`:
```markdown
# PostgreSQL Docker Setup Guide

## Commands Used
```bash
docker run --name postgres-sql-training \
  -e POSTGRES_DB=training \
  -e POSTGRES_USER=student \
  -e POSTGRES_PASSWORD=securepass123 \
  -p 5432:5432 \
  -d postgres:15
```

## Connection Details
- Host: localhost
- Port: 5432
- Database: training
- Username: student
- Password: securepass123

## Useful Commands
- Start: `docker start postgres-sql-training`
- Stop: `docker stop postgres-sql-training`
- Logs: `docker logs postgres-sql-training`
- Remove: `docker rm postgres-sql-training`
```

#### 🎯 **End-of-Day Checklist**
- [ ] Docker Desktop ติดตั้งและทำงานได้
- [ ] PostgreSQL container running successfully
- [ ] เชื่อมต่อ database ได้ผ่าน docker exec
- [ ] สร้าง test table และ insert data ได้
- [ ] Commit code ลง GitHub
- [ ] เขียนสรุปสิ่งที่เรียนรู้

---

## 🚀 **วันที่ 2: Docker Compose & DBeaver Integration** (12 กันยายน 2568)

### ⏰ **ช่วงที่ 1 (25 นาที): Docker Compose Introduction**

#### 🎯 Learning Objectives
- เข้าใจความแตกต่างระหว่าง docker run และ docker-compose
- สร้าง docker-compose.yml ครั้งแรก

#### 📚 เนื้อหา
**ทำไมต้องใช้ Docker Compose? (10 นาที)**
```
Without Docker Compose:
docker run --name postgres ... (คำสั่งยาว)
docker run --name pgadmin ... (อีกคำสั่งยาว)
docker network create ... (ต้องสร้าง network เอง)

With Docker Compose:
docker-compose up (คำสั่งเดียว สำหรับหลาย services)
```

**สร้าง docker-compose.yml (15 นาที)**
```yaml
# สร้างไฟล์ docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:15
    container_name: postgres-sql-training
    environment:
      POSTGRES_DB: training
      POSTGRES_USER: student
      POSTGRES_PASSWORD: securepass123
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init:/docker-entrypoint-initdb.d
    restart: unless-stopped

  pgadmin:
    image: dpage/pgadmin4
    container_name: pgadmin-training
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@training.com
      PGADMIN_DEFAULT_PASSWORD: admin123
    ports:
      - "8080:80"
    depends_on:
      - postgres
    restart: unless-stopped

volumes:
  postgres_data:
```

#### 🛠️ Hands-on Activity
```bash
# ถ้ามี container เก่าอยู่ ลบก่อน
docker stop postgres-sql-training
docker rm postgres-sql-training

# สร้าง directory structure
mkdir sql-training-docker
cd sql-training-docker
mkdir init

# สร้าง docker-compose.yml (ตามด้านบน)
# แล้วรัน
docker-compose up -d

# ตรวจสอบ services
docker-compose ps
```

---

### ⏰ **ช่วงที่ 2 (25 นาที): pgAdmin Setup & Integration**

#### 🎯 Learning Objectives
- เข้าใช้ pgAdmin ผ่าน web interface
- เชื่อมต่อ pgAdmin กับ PostgreSQL container

#### 🛠️ Hands-on Activity
1. **เปิด pgAdmin**: http://localhost:8080
2. **Login**: admin@training.com / admin123
3. **Add Server**:
   - Server name: `Docker PostgreSQL`
   - Host: `postgres` (service name ใน docker-compose)
   - Port: `5432`
   - Username: `student`
   - Password: `securepass123`

4. **ทดสอบการทำงาน**:
   ```sql
   -- สร้าง schema ใหม่
   CREATE SCHEMA learning;
   
   -- สร้าง table ใน schema ใหม่
   CREATE TABLE learning.students (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100),
       skill_level VARCHAR(50),
       start_date DATE DEFAULT CURRENT_DATE
   );
   
   -- Insert ข้อมูล
   INSERT INTO learning.students (name, skill_level) 
   VALUES ('Data Engineer Student', 'Intermediate');
   
   SELECT * FROM learning.students;
   ```

---

### ⏰ **ช่วงที่ 3 (25 นาที): DBeaver Connection**

#### 🎯 Learning Objectives
- เชื่อมต่อ DBeaver กับ PostgreSQL container
- เปรียบเทียบ DBeaver vs pgAdmin

#### 🛠️ DBeaver Setup
1. **เปิด DBeaver**
2. **New Database Connection**:
   - Database: PostgreSQL
   - Host: localhost
   - Port: 5432
   - Database: training
   - Username: student
   - Password: securepass123
   - Test Connection

3. **ทดสอบใน DBeaver**:
   ```sql
   -- ดู schemas ทั้งหมด
   SELECT schema_name FROM information_schema.schemata;
   
   -- ดู tables ใน learning schema
   SELECT table_name FROM information_schema.tables 
   WHERE table_schema = 'learning';
   
   -- Query ข้อมูล
   SELECT * FROM learning.students;
   ```

#### 📊 **Tool Comparison**
| Feature | pgAdmin | DBeaver |
|---------|---------|---------|
| Interface | Web-based | Desktop app |
| Speed | Slower (web) | Faster (native) |
| Multi-DB | PostgreSQL only | Multiple databases |
| Advanced features | PostgreSQL-specific | Universal |
| **Recommendation** | Development/Admin | Daily SQL work |

---

### ⏰ **ช่วงที่ 4 (25 นาที): Volume Management & Initialization**

#### 🎯 Learning Objectives
- เข้าใจ Volume persistence
- สร้าง initialization scripts

#### 📚 **Volume Management**
```bash
# ดู volumes
docker volume ls

# ตรวจสอบข้อมูลใน volume
docker volume inspect sql-training-docker_postgres_data

# Backup volume
docker run --rm -v sql-training-docker_postgres_data:/data -v $(pwd):/backup alpine tar czf /backup/postgres-backup.tar.gz -C /data .

# ทดสอบ persistence
docker-compose down
docker-compose up -d
# → ข้อมูลยังอยู่
```

#### 🛠️ **Initialization Scripts**
สร้างไฟล์ `init/01-init-schema.sql`:
```sql
-- สร้าง schemas และ tables เริ่มต้น
CREATE SCHEMA IF NOT EXISTS training_data;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS analytics;

-- สร้าง sample tables
CREATE TABLE training_data.sample_orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

-- Insert sample data
INSERT INTO training_data.sample_orders (customer_name, order_date, amount, status) VALUES
('John Doe', '2024-09-01', 150.00, 'completed'),
('Jane Smith', '2024-09-02', 275.50, 'pending'),
('Bob Johnson', '2024-09-03', 99.99, 'cancelled');

-- สร้าง user สำหรับ analytics
CREATE USER analytics_user WITH PASSWORD 'analytics123';
GRANT USAGE ON SCHEMA analytics TO analytics_user;
GRANT ALL ON ALL TABLES IN SCHEMA analytics TO analytics_user;
```

#### 🔄 **Test Initialization**
```bash
# Recreate containers to test init scripts
docker-compose down -v  # ลบ volumes ด้วย
docker-compose up -d
# ข้อมูลจะถูกสร้างอัตโนมัติจาก init scripts
```

---

## 🚀 **วันที่ 3: Advanced Docker & Production Readiness** (13 กันยายน 2568)

### ⏰ **ช่วงที่ 1 (25 นาที): Environment Management**

#### 🎯 Learning Objectives
- ใช้ .env files สำหรับ configuration
- เข้าใจ security best practices

#### 🛠️ **Environment Configuration**
สร้างไฟล์ `.env`:
```env
# Database Configuration
POSTGRES_DB=training
POSTGRES_USER=student
POSTGRES_PASSWORD=securepass123
POSTGRES_PORT=5432

# pgAdmin Configuration  
PGADMIN_EMAIL=admin@training.com
PGADMIN_PASSWORD=admin123
PGADMIN_PORT=8080

# Environment
ENV=development
```

แก้ไข `docker-compose.yml`:
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    container_name: postgres-sql-training
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "${POSTGRES_PORT}:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init:/docker-entrypoint-initdb.d
    restart: unless-stopped

  pgadmin:
    image: dpage/pgadmin4
    container_name: pgadmin-training
    environment:
      PGADMIN_DEFAULT_EMAIL: ${PGADMIN_EMAIL}
      PGADMIN_DEFAULT_PASSWORD: ${PGADMIN_PASSWORD}
    ports:
      - "${PGADMIN_PORT}:80"
    depends_on:
      - postgres
    restart: unless-stopped
    profiles:
      - admin

volumes:
  postgres_data:
```

---

### ⏰ **ช่วงที่ 2 (25 นาที): Health Checks & Monitoring**

#### 🎯 Learning Objectives
- เพิ่ม health checks
- Monitor container status

#### 🛠️ **Health Checks Implementation**
แก้ไข `docker-compose.yml` เพิ่ม health checks:
```yaml
  postgres:
    image: postgres:15
    # ... other configs
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s
```

#### 📊 **Monitoring Commands**
```bash
# ตรวจสอบ health status
docker-compose ps

# ดู resource usage
docker stats

# ดู logs แบบ real-time
docker-compose logs -f postgres

# ดู logs เฉพาะ error
docker-compose logs postgres | grep -i error
```

---

### ⏰ **ช่วงที่ 3 (25 นาที): Backup & Recovery**

#### 🎯 Learning Objectives
- สร้าง backup scripts
- ทดสอบ recovery process

#### 🛠️ **Backup Scripts**
สร้างไฟล์ `scripts/backup.sh`:
```bash
#!/bin/bash
# PostgreSQL Backup Script

BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="postgres_backup_${DATE}.sql"

# สร้าง backup directory
mkdir -p $BACKUP_DIR

# สร้าง backup
docker exec postgres-sql-training pg_dump -U student -d training > $BACKUP_DIR/$BACKUP_FILE

echo "Backup completed: $BACKUP_DIR/$BACKUP_FILE"
```

สร้างไฟล์ `scripts/restore.sh`:
```bash
#!/bin/bash
# PostgreSQL Restore Script

if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_file>"
    exit 1
fi

BACKUP_FILE=$1

# Drop และสร้าง database ใหม่
docker exec postgres-sql-training dropdb -U student training
docker exec postgres-sql-training createdb -U student training

# Restore จาก backup
docker exec -i postgres-sql-training psql -U student -d training < $BACKUP_FILE

echo "Restore completed from: $BACKUP_FILE"
```

#### 🧪 **Testing Backup/Restore**
```bash
# สร้าง backup
bash scripts/backup.sh

# ลบข้อมูลทดสอบ
docker exec postgres-sql-training psql -U student -d training -c "DROP SCHEMA learning CASCADE;"

# Restore
bash scripts/restore.sh backups/postgres_backup_*.sql

# ตรวจสอบข้อมูล
docker exec postgres-sql-training psql -U student -d training -c "SELECT * FROM learning.students;"
```

---

### ⏰ **ช่วงที่ 4 (25 นาที): Documentation & Next Steps**

#### 🎯 Learning Objectives
- สร้าง comprehensive documentation
- เตรียมพร้อมสำหรับ SQL training

#### 📝 **Final Documentation**
สร้างไฟล์ `README.md`:
```markdown
# SQL Training Docker Environment

## Quick Start
```bash
# Clone repository
git clone <your-repo>
cd sql-training-journey/week0-docker

# Start environment
docker-compose up -d

# Stop environment  
docker-compose down
```

## Connections
- **DBeaver**: localhost:5432, training/student/securepass123
- **pgAdmin**: http://localhost:8080, admin@training.com/admin123

## Useful Commands
```bash
# Backup
bash scripts/backup.sh

# Restore
bash scripts/restore.sh backups/backup_file.sql

# Logs
docker-compose logs -f postgres

# Health check
docker-compose ps
```

## Project Structure
```
week0-docker/
├── docker-compose.yml
├── .env
├── init/
│   └── 01-init-schema.sql
├── scripts/
│   ├── backup.sh
│   └── restore.sh
└── backups/
```
```

#### 🎯 **Final Checklist**
- [ ] Docker Compose environment working
- [ ] DBeaver และ pgAdmin เชื่อมต่อได้
- [ ] Health checks working
- [ ] Backup/restore scripts tested
- [ ] Environment variables configured
- [ ] Documentation complete
- [ ] Ready for SQL training!

---

## 🎊 **Completion Summary**

### ✅ **สิ่งที่คุณได้เรียนรู้**
- Docker fundamentals และ containerization concepts
- PostgreSQL container setup และ management
- Docker Compose สำหรับ multi-service applications
- Environment management และ security practices  
- Backup/restore procedures
- Health monitoring และ troubleshooting

### 🚀 **พร้อมสำหรับ SQL Training**
- PostgreSQL environment พร้อมใช้งาน
- DBeaver connection ทำงานได้
- Docker workflow ที่เสร็จสมบูรณ์
- Documentation และ scripts ครบถ้วน

### 📋 **Next Steps** (วันที่ 14 กันยายน 2568)
- เริ่ม **สัปดาห์ 1: Intermediate SQL Refresher**
- Setup Claude Code integration
- Begin AI-assisted SQL development workflow

**🎯 ยินดีด้วย! คุณพร้อมเป็น Modern Data Engineer แล้ว!** 🎉