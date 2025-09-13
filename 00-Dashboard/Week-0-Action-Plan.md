# 🚀 Week 0 Action Plan - การเริ่มต้น SQL Training Journey

## 🎯 เป้าหมายสัปดาห์นี้
ตั้งค่า Development Environment และทำความรู้จักเครื่องมือพื้นฐานสำหรับการเรียน SQL แบบ Modern Data Engineering

---

## 📅 แผนการดำเนินงาน 4 วัน

### 📋 **วันที่ 1: Docker Foundation + PostgreSQL Setup**
**⏰ เป้าหมาย: 2 ชั่วโมง (4 ช่วง x 25 นาที)**

#### 🔧 ช่วงที่ 1 (25 นาที): ทำความเข้าใจ Docker
- **เป้าหมาย**: เข้าใจว่า Docker คืออะไร และทำไม Data Engineer ต้องใช้
- **กิจกรรม**: 
  - อ่าน Docker concepts สำหรับ Data Engineering
  - ดู demo การใช้ Docker ในการจัดการ databases
- **ผลลัพธ์**: เข้าใจประโยชน์ของ containerization

#### 💻 ช่วงที่ 2 (25 นาที): ติดตั้ง Docker Desktop
- **เป้าหมาย**: ติดตั้งและทดสอบ Docker บน Windows 11
- **กิจกรรม**:
  ```bash
  # ดาวน์โหลด Docker Desktop จาก
  # https://www.docker.com/products/docker-desktop
  
  # ทดสอบการติดตั้งด้วย
  docker --version
  docker run hello-world
  ```
- **ผลลัพธ์**: Docker Desktop ทำงานได้ปกติ

#### 🐘 ช่วงที่ 3 (25 นาที): รัน PostgreSQL Container
- **เป้าหมาย**: สร้าง PostgreSQL database ใน Docker container
- **กิจกรรม**:
  ```bash
  # สร้าง PostgreSQL container
  docker run --name postgres-training \
    -e POSTGRES_DB=training \
    -e POSTGRES_USER=student \
    -e POSTGRES_PASSWORD=securepass123 \
    -p 5432:5432 \
    -v postgres_data:/var/lib/postgresql/data \
    -d postgres:15
  
  # ตรวจสอบสถานะ
  docker ps
  docker logs postgres-training
  ```
- **ผลลัพธ์**: PostgreSQL container ทำงาน

#### 🔗 ช่วงที่ 4 (25 นาที): ทดสอบ Connection
- **เป้าหมาย**: เชื่อมต่อ database และทดสอบการทำงาน
- **กิจกรรม**: ติดตั้ง DBeaver และ connect ไปยัง PostgreSQL
- **Connection String**: `postgresql://student:securepass123@localhost:5432/training`
- **ผลลัพธ์**: เชื่อมต่อได้สำเร็จ และรัน SELECT 1; ได้

---

### 🤖 **วันที่ 2: AI Tools Integration**
**⏰ เป้าหมาย: 2 ชั่วโมง (4 ช่วง x 25 นาที)**

#### 🎯 ช่วงที่ 1 (25 นาที): Claude Code Introduction
- **เป้าหมาย**: ทำความรู้จัก Claude Code สำหรับ SQL development
- **กิจกรรม**:
  - เรียนรู้ Claude Code interface และ capabilities
  - ทดลอง basic SQL generation
- **ผลลัพธ์**: เข้าใจวิธีใช้ Claude Code พื้นฐาน

#### 💬 ช่วงที่ 2 (25 นาที): AI Prompting for SQL
- **เป้าหมาย**: เรียนรู้เทคนิคการสื่อสารกับ AI สำหรับ SQL
- **กิจกรรม**:
  - ฝึก prompting techniques
  - ทดลองสร้าง SQL queries ด้วย AI
- **ตัวอย่าง Prompts**:
  ```
  "Create a PostgreSQL table for storing customer data with 
  appropriate data types and constraints"
  
  "Generate an optimized query to find top 10 customers 
  by total purchase amount"
  ```
- **ผลลัพธ์**: สามารถใช้ AI สร้าง SQL ได้

#### ⚙️ ช่วงที่ 3 (25 นาที): VS Code + SQL Extensions
- **เป้าหมาย**: ตั้งค่า text editor สำหรับเขียน SQL
- **กิจกรรม**: ติดตั้ง VS Code และ PostgreSQL extensions
- **Extensions แนะนำ**:
  - PostgreSQL (by Microsoft)
  - SQL Tools
  - GitLens (สำหรับ version control)
- **ผลลัพธ์**: Environment สำหรับเขียน SQL พร้อมใช้

#### 🧪 ช่วงที่ 4 (25 นาที): AI-Assisted SQL Practice
- **เป้าหมาย**: ฝึกเขียน SQL โดยใช้ AI ช่วย
- **กิจกรรม**:
  - สร้างตารางทดสอบด้วยความช่วยเหลือของ AI
  - เขียน queries แบบต่างๆ
- **ผลลัพธ์**: Workflow การทำงานร่วมกับ AI

#### 📝 **Session End (15 นาที): Documentation & Portfolio**
- **เป้าหมาย**: บันทึก Session Summary สำหรับ Portfolio
- **กิจกรรม**:
  - สร้าง Session Summary ตาม Session-End-Checklist
  - อัปเดต Progress Trackers ทุกไฟล์
  - บันทึกทักษะและผลงานที่ได้รับ
- **ผลลัพธ์**: เอกสาร Portfolio พร้อมสำหรับสมัครงาน

---

### 📊 **วันที่ 3: Performance Concepts Introduction**
**⏰ เป้าหมาย: 2 ชั่วโมง (4 ช่วง x 25 นาที)**

#### 📈 ช่วงที่ 1-2 (50 นาที): SQL Execution Plans
- **เป้าหมาย**: เข้าใจการอ่าน Execution Plan ใน PostgreSQL
- **กิจกรรม**:
  ```sql
  -- ทำความเข้าใจ EXPLAIN
  EXPLAIN SELECT * FROM customers;
  
  -- ทดลอง EXPLAIN ANALYZE
  EXPLAIN ANALYZE SELECT * FROM large_table;
  ```
- **สิ่งที่เรียนรู้**: Cost, Rows, Time, เข้าใจ query execution path
- **ผลลัพธ์**: อ่าน execution plan พื้นฐานได้

#### 🗂️ ช่วงที่ 3-4 (50 นาที): Basic Indexing
- **เป้าหมาย**: เรียนรู้ Index concepts และการทดสอบ
- **กิจกรรม**:
  ```sql
  -- สร้าง table และข้อมูลทดสอบ
  CREATE TABLE performance_test AS 
  SELECT generate_series(1,100000) as id, 
         random()::text as data;
  
  -- ทดสอบ query ก่อนมี index
  EXPLAIN ANALYZE SELECT * FROM performance_test WHERE id = 50000;
  
  -- สร้าง index
  CREATE INDEX idx_performance_test_id ON performance_test(id);
  
  -- ทดสอบหลังมี index
  EXPLAIN ANALYZE SELECT * FROM performance_test WHERE id = 50000;
  ```
- **ผลลัพธ์**: เห็นผลของ index ต่อ performance

---

### 🔄 **วันที่ 4: Integration Testing & Review**
**⏰ เป้าหมาย: 2 ชั่วโมง (4 ช่วง x 25 นาที)**

#### 🧩 ช่วงที่ 1-2 (50 นาที): Docker Compose Setup
- **เป้าหมาย**: ใช้ Docker Compose จัดการ multi-container
- **กิจกรรม**: สร้าง docker-compose.yml สำหรับ PostgreSQL + pgAdmin
- **ไฟล์ docker-compose.yml**:
  ```yaml
  version: '3.8'
  services:
    postgres:
      image: postgres:15
      environment:
        POSTGRES_DB: training
        POSTGRES_USER: student
        POSTGRES_PASSWORD: securepass123
      ports:
        - "5432:5432"
      volumes:
        - postgres_data:/var/lib/postgresql/data
    
    pgadmin:
      image: dpage/pgadmin4
      environment:
        PGADMIN_DEFAULT_EMAIL: admin@training.com
        PGADMIN_DEFAULT_PASSWORD: admin123
      ports:
        - "8080:80"
      depends_on:
        - postgres
  
  volumes:
    postgres_data:
  ```
- **ผลลัพธ์**: Environment ที่สมบูรณ์พร้อมใช้

#### ✅ ช่วงที่ 3-4 (50 นาที): End-to-End Testing
- **เป้าหมาย**: ทดสอบทุกอย่างที่ติดตั้งมา
- **กิจกรรม**:
  - ทดสอบ DBeaver connection
  - ทดสอบ pgAdmin web interface
  - ใช้ AI สร้าง complex query
  - วิเคราะห์ performance ด้วย EXPLAIN
- **ผลลัพธ์**: ระบบทั้งหมดทำงานร่วมกันได้

---

## ✅ Checklist การเสร็จสิ้น Week 0

### 🔧 Technical Setup
- [x] Docker Desktop ติดตั้งและทำงานได้
- [x] PostgreSQL container รันได้
- [x] DBeaver เชื่อมต่อได้
- [ ] VS Code + SQL extensions พร้อมใช้
- [ ] Docker Compose ทำงานได้

### 🤖 AI Integration
- [ ] ใช้ Claude Code สร้าง SQL ได้
- [ ] เข้าใจ AI prompting techniques
- [ ] Workflow การทำงานร่วมกับ AI

### 📊 Performance Foundation
- [x] อ่าน EXPLAIN output ได้พื้นฐาน
- [x] เข้าใจผลของ Index ต่อ performance
- [x] รู้จักเครื่องมือ performance analysis

### 📚 Knowledge Check
- [x] เข้าใจประโยชน์ของ Docker สำหรับ Data Engineering
- [x] รู้จัก PostgreSQL พื้นฐาน
- [x] เข้าใจแนวคิด performance optimization พื้นฐาน

### 🎯 Day 1 สำเร็จแล้ว! (11 กันยายน 2567)
- [x] Docker concepts และการใช้งานใน Data Engineering
- [x] PostgreSQL container setup และการใช้งาน
- [x] DBeaver installation และ database connection
- [x] Basic SQL commands testing และการทดสอบ

### 🚀 Day 2 เริ่มต้นแล้ว! (12 กันยายน 2567)
- [ ] Claude Code introduction และ basic usage
- [ ] AI Prompting techniques สำหรับ SQL
- [ ] VS Code + SQL extensions setup
- [ ] AI-assisted SQL practice

---

## 🚀 เตรียมพร้อมสู่ Week 1

### สิ่งที่จะเริ่มในสัปดาห์หน้า:
1. **Window Functions with Performance Focus**
2. **AI-Powered Query Generation**
3. **Advanced EXPLAIN Analysis**
4. **Performance Benchmarking**

### คำถามสำหรับการเตรียมตัว:
- มี dataset เฉพาะที่อยากใช้ฝึกหรือไม่?
- มี performance challenge เฉพาะที่เคยพบมาไหม?
- ต้องการ focus เพิ่มเติมในส่วนใดของ AI tools?

---

*🎯 Week 0 นี้เป็นการวางรากฐานสำคัญ - อย่าเพิ่งแก้ปัญหาซับซ้อน ให้โฟกัสที่การทำให้ทุกอย่างทำงานได้ก่อน!*