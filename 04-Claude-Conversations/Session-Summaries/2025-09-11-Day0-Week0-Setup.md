# 💬 Week 0 Day 1 - Docker Foundation Session

## ℹ️ ข้อมูลเซสชัน
- **วันที่**: 11 กันยายน 2567
- **เวลา**: Day 1 Session
- **หัวข้อหลัก**: Docker Foundation + PostgreSQL Setup
- **ระดับ**: Beginner Docker + Intermediate SQL
- **สัปดาห์ที่**: Week 0 - Day 1

## 🎯 วัตถุประสงค์วันนี้
- เข้าใจ Docker และประโยชน์สำหรับ Data Engineering
- ติดตั้ง Docker Desktop บน Windows 11
- รัน PostgreSQL container ครั้งแรก
- ทดสอบการเชื่อมต่อ database

---

## 🔧 ช่วงที่ 1: ทำความเข้าใจ Docker (25 นาที)

### 🎯 เป้าหมาย
เข้าใจว่า Docker คืออะไร และทำไม Data Engineer ต้องใช้

### 📚 สิ่งที่เรียนรู้

#### Docker คืออะไร?
**Docker** คือแพลตฟอร์มที่ใช้สร้าง, deploy และรัน applications ผ่าน **containers**

#### Container vs Virtual Machine
```
Virtual Machine (VM):
┌─────────────────────────┐
│     Application A       │
├─────────────────────────┤
│       Guest OS          │
├─────────────────────────┤
│      Hypervisor         │
├─────────────────────────┤
│       Host OS           │
└─────────────────────────┘

Docker Container:
┌─────────────────────────┐
│     Application A       │
├─────────────────────────┤
│    Docker Engine        │
├─────────────────────────┤
│       Host OS           │
└─────────────────────────┘
```

#### ทำไม Data Engineer ต้องใช้ Docker?

**1. Environment Consistency** 🎯
- Development, Testing, Production ใช้ environment เดียวกัน
- ไม่มีปัญหา "works on my machine"

**2. Easy Database Management** 🗄️
- ติดตั้ง PostgreSQL, MySQL, MongoDB ได้ใน 1 คำสั่ง
- ไม่ต้องกังวลเรื่อง version conflicts
- ง่ายต่อการ cleanup

**3. Scalability & Portability** 🚀
- ย้าย application ไปยัง cloud ได้ง่าย
- Scale up/down ตามความต้องการ
- รองรับ Kubernetes, Docker Swarm

**4. Isolation** 🛡️
- Database แต่ละตัวแยกจากกัน
- ไม่มีผลกระทบระหว่าง projects
- ปลอดภัยกว่า

#### Docker Components สำคัญ

**Image**: Template สำหรับสร้าง container
**Container**: Instance ที่รันจาก image  
**Volume**: เก็บข้อมูลถาวรนอก container
**Network**: เชื่อมต่อ containers เข้าด้วยกัน

### ✅ ความเข้าใจที่ได้รับ
- Docker ช่วยให้ Data Engineer จัดการ databases ได้ง่าย
- Container มี overhead น้อยกว่า VM
- เหมาะสำหรับ modern data stack

### 📋 Action Items สำหรับช่วงถัดไป
- [ ] ดาวน์โหลด Docker Desktop
- [ ] ตรวจสอบ system requirements

---

## 💻 ช่วงที่ 2: ติดตั้ง Docker Desktop ✅

### ✅ ความสำเร็จ
- ผู้เรียนมี Docker Desktop ทำงานอยู่แล้ว
- PostgreSQL container พร้อมใช้งาน
- ข้ามไปช่วงต่อไป

---

## 🐘 ช่วงที่ 3: รัน PostgreSQL Container ✅

### ✅ ความสำเร็จ
- Container `postgres-sql-training` ทำงานได้ปกติ
- PostgreSQL 15.14 พร้อมใช้งาน
- Database `training` accessible
- ทดสอบ psql connection สำเร็จ

---

## 🔗 ช่วงที่ 4: ทดสอบ Connection ✅

### ✅ Task 1: ติดตั้ง DBeaver
- Status: ✅ สำเร็จ
- DBeaver Community Edition ติดตั้งและเปิดได้

### ✅ Task 2: สร้าง Database Connection
- Status: ✅ สำเร็จ
- Connection test: Connected (5049 ms)
- PostgreSQL 15.14 detected
- Database Navigator แสดงการเชื่อมต่อ

### ✅ Task 3: ทดสอบ SQL Commands
- Command 1 (SELECT version()): ✅ PostgreSQL 15.14 (Debian)
- Command 2 (SELECT NOW()): ✅ 2025-09-11 16:37:53.324 +0700  
- Command 3 (calculation): ✅ result = 2, message = "hello postgresql!"
- ไม่มี errors

---

## 📊 สรุปผลการเรียนรู้ Day 1

### 🎯 เป้าหมายที่บรรลุ
- [x] เข้าใจแนวคิด Docker สำหรับ Data Engineering
- [x] PostgreSQL container ทำงานได้
- [x] DBeaver เชื่อมต่อได้สำเร็จ
- [x] ทดสอบ SQL commands ได้

### 💪 ทักษะที่ได้รับ
- ความเข้าใจ Docker concepts และประโยชน์
- การใช้งาน PostgreSQL ใน container
- การเชื่อมต่อ database ด้วย DBeaver
- การรัน SQL commands พื้นฐาน

### 🚀 ความพร้อมสำหรับ Day 2
- Environment setup สมบูรณ์
- เครื่องมือพื้นฐานพร้อมใช้
- Foundation สำหรับ AI Tools Integration

### ⏱️ เวลารวมที่ใช้
- ประมาณ 2 ชั่วโมงตามแผน
- ทุกขั้นตอนสำเร็จตาม checklist

---

*Day 1 สำเร็จสมบูรณ์ - พร้อมก้าวไปสู่ Day 2: AI Tools Integration! 🎉*