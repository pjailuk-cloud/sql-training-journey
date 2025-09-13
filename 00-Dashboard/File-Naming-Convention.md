# 📁 File Naming Convention - SQL Training Journey

## 🎯 **Purpose**
ข้อกำหนดมาตรฐานสำหรับการตั้งชื่อไฟล์ในโปรเจค SQL Training Journey เพื่อให้มีความสม่ำเสมอและง่ายต่อการจัดการ

---

## 📋 **General Naming Rules**

### 🔤 **Basic Principles**
- ใช้ **Gregorian calendar** (2025, 2026, ...)
- ใช้ **English characters** สำหรับชื่อไฟล์
- ใช้ **kebab-case** (dash-separated)
- **ไม่ใช้ spaces** ในชื่อไฟล์
- **ไม่ใช้ special characters** ยกเว้น dash (-) และ underscore (_)

### 📅 **Date Format**
- **Standard**: `YYYY-MM-DD` (ISO 8601)
- **Example**: `2025-09-13` (13 กันยายน 2025)

---

## 📂 **Folder-Specific Naming Conventions**

### 📊 **1. Session-Summaries/**
```
Format: YYYY-MM-DD-Day{N}-{Session-Name}.md

Examples:
✅ 2025-09-11-Day1-Docker-PostgreSQL-Setup.md
✅ 2025-09-12-Day2-AI-Tools-Integration.md
✅ 2025-09-13-Day3-Advanced-Docker-Production.md

Components:
- YYYY-MM-DD: Session date
- Day{N}: Day number (Day0, Day1, Day2, etc.)
- {Session-Name}: Descriptive session topic
- .md: Markdown extension
```

### 🎓 **2. Learning-Sessions/**
```
Format: Week-{NN}-{Topic-Name}/

Examples:
✅ Week-00-Docker/
✅ Week-01-SQL-Refresher/
✅ Week-02-Advanced-SQL/

Sub-files:
✅ Week-00-Docker/2025-09-11-Docker-Setup.md
✅ Week-01-SQL-Refresher/2025-09-16-Window-Functions.md
```

### 💻 **3. Code-Solutions/**
```
Format: {Technology}/{Project-Name}/

Examples:
✅ Docker/production-setup/
✅ PostgreSQL/analytics-queries/
✅ Projects/e-commerce-dashboard/

Files within:
✅ docker-compose.yml
✅ .env.example
✅ init-scripts/01-init-database.sql
```

### 📚 **4. Resources/**
```
Format: {Category}/{Descriptive-Name}.md

Examples:
✅ References/Context.md
✅ Templates/Session-Summary-Template.md
✅ Cheatsheets/PostgreSQL-Commands.md
```

### 🤖 **5. Claude-Conversations/**
```
Session-Summaries/: (see above)
Q-A-Archive/: YYYY-MM-DD-{Topic}.md

Examples:
✅ Q-A-Archive/2025-09-13-Docker-Volume-Questions.md
✅ Q-A-Archive/2025-09-15-SQL-Performance-Tips.md
```

---

## 🎯 **Specific File Types**

### 📄 **Markdown Files (.md)**
```
Session Summaries: YYYY-MM-DD-Day{N}-{Session-Name}.md
Documentation: {Descriptive-Name}.md
Templates: {Template-Name}-Template.md

Examples:
✅ 2025-09-13-Day3-Advanced-Docker-Production.md
✅ Docker-Compose-Guide.md
✅ Session-End-Checklist-Template.md
```

### 💾 **SQL Files (.sql)**
```
Format: {NN}-{descriptive-name}.sql

Examples:
✅ 01-init-database.sql
✅ 02-create-indexes.sql
✅ 03-sample-data.sql
```

### 🐳 **Docker Files**
```
Standard Names:
✅ docker-compose.yml
✅ Dockerfile
✅ .env (not committed)
✅ .env.example (committed)

Custom Configurations:
✅ docker-compose.prod.yml
✅ docker-compose.dev.yml
```

### 📊 **Configuration Files**
```
Environment: .env, .env.example, .env.production
Config: config.yml, settings.json
Scripts: setup.sh, deploy.sh, backup.sh
```

---

## ⚠️ **What NOT to Do**

### ❌ **Invalid Examples**
```
❌ 2567-09-13-day3.md (wrong calendar + no capitalization)
❌ Day 3 Summary.md (spaces in filename)
❌ day3_summary.md (no date, underscore instead of dash)
❌ 2025/09/13-Day3.md (slashes not allowed)
❌ Day3-สรุป.md (Thai characters in filename)
❌ summary.md (not descriptive enough)
```

### ❌ **Common Mistakes**
- Using Buddhist calendar (2567, 2568) instead of Gregorian (2025)
- Mixing languages in filenames
- Using spaces instead of dashes
- Inconsistent capitalization
- Missing date information
- Too generic names

---

## 📋 **Quick Reference Checklist**

### ✅ **Before Creating Any File:**
- [ ] Date format: `YYYY-MM-DD` (Gregorian calendar)
- [ ] No spaces in filename
- [ ] Use dashes (-) for separation
- [ ] Descriptive but concise name
- [ ] Consistent with folder conventions
- [ ] Proper file extension

### ✅ **Session Summary Checklist:**
- [ ] Format: `YYYY-MM-DD-Day{N}-{Session-Name}.md`
- [ ] Day number matches actual day
- [ ] Session name describes main topic
- [ ] Date matches actual session date

### ✅ **Code File Checklist:**
- [ ] Organized in appropriate technology folder
- [ ] SQL files numbered sequentially (01-, 02-, etc.)
- [ ] Docker files use standard names
- [ ] Configuration files have .example versions

---

## 🔄 **Migration & Updates**

### 📝 **When Renaming Existing Files:**
1. Check for any references in other documents
2. Update links in markdown files
3. Update any scripts or automation
4. Verify git history preservation if needed

### 📊 **Validation Commands:**
```bash
# Check for files with spaces
find . -name "* *" -type f

# Check for non-ASCII characters
find . -name "*[^[:ascii:]]*" -type f

# List all session summaries
ls -la 04-Claude-Conversations/Session-Summaries/
```

---

## 📈 **Benefits of This Convention**

### 🎯 **Advantages:**
- **Chronological Sorting**: Files sort naturally by date
- **Easy Search**: Predictable naming patterns
- **Cross-Platform**: Works on all operating systems
- **Professional**: Industry-standard practices
- **Git-Friendly**: No special character issues
- **Automation-Ready**: Scripts can parse names easily

### 🔍 **Search Examples:**
```bash
# Find all Day 1 sessions
ls *Day1*.md

# Find all September 2025 files
ls 2025-09-*.md

# Find all Docker-related content
find . -name "*Docker*" -type f
```

---

## 📚 **Examples by Use Case**

### 🎓 **Learning Session Documentation**
```
✅ 2025-09-16-Day4-Window-Functions-Mastery.md
✅ 2025-09-17-Day5-Performance-Optimization.md
✅ 2025-09-18-Day6-Real-World-Projects.md
```

### 💻 **Code Projects**
```
✅ Projects/e-commerce-analytics/
   ├── docker-compose.yml
   ├── .env.example
   ├── sql/01-schema.sql
   ├── sql/02-indexes.sql
   └── docs/project-overview.md
```

### 📊 **Reference Materials**
```
✅ References/PostgreSQL-Performance-Guide.md
✅ Cheatsheets/Docker-Commands.md
✅ Templates/Project-Structure-Template.md
```

---

## 🔧 **Tools & Automation**

### 📝 **Template for Session Summaries**
```bash
# Auto-generate session summary filename
DATE=$(date +%Y-%m-%d)
DAY_NUM="Day4"  # Update manually
SESSION_NAME="Topic-Name"
FILENAME="${DATE}-${DAY_NUM}-${SESSION_NAME}.md"
echo "Creating: $FILENAME"
```

### 🎯 **Validation Script**
```bash
#!/bin/bash
# Check if filename follows convention
validate_session_summary() {
    if [[ $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-Day[0-9]+-[A-Za-z0-9-]+\.md$ ]]; then
        echo "✅ Valid: $1"
    else
        echo "❌ Invalid: $1"
    fi
}
```

---

**📝 Created**: 2025-09-13  
**🔄 Last Updated**: 2025-09-13  
**📍 Location**: `00-Dashboard/File-Naming-Convention.md`  
**🎯 Purpose**: Standardize file naming across SQL Training Journey project

---

*🎯 Following this convention ensures consistency, professionalism, and ease of management across the entire project!*