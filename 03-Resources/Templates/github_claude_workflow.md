# 🤝 GitHub + Claude Code Workflow - ขั้นตอนการทำงานร่วมกัน

## 🏗️ **GitHub Repository Structure**

### 📁 **Repository Layout: `sql-training-journey`**
```
sql-training-journey/
├── README.md                          # ภาพรวมโปรเจกต์
├── .gitignore                         # ไฟล์ที่ไม่ต้อง commit
├── week0-docker/                      # Docker Quick Start
│   ├── docker-compose.yml
│   ├── .env.example
│   ├── init/
│   ├── scripts/
│   └── README.md
├── week1-sql-refresher/              # SQL Refresher
│   ├── exercises/
│   ├── solutions/
│   └── notes/
├── week2-modern-setup/               # Claude Code + AI Setup
│   ├── claude-code-config/
│   ├── ai-prompts/
│   └── examples/
├── projects/                         # โปรเจกต์หลัก
│   ├── real-world-integration/
│   ├── data-warehousing/
│   └── performance-optimization/
├── resources/                        # ทรัพยากรเรียนรู้
│   ├── datasets/
│   ├── templates/
│   └── references/
└── docs/                            # เอกสารเพิ่มเติม
    ├── progress-tracking.md
    ├── ai-workflow-guide.md
    └── troubleshooting.md
```

---

## 🤖 **Claude Code Integration Strategy**

### 📅 **Phase 1: Setup & Basic Integration** (สัปดาห์ 2)

#### 🔧 **Claude Code Configuration**
```bash
# สร้าง Claude Code config directory
mkdir week2-modern-setup/claude-code-config
cd week2-modern-setup/claude-code-config

# สร้าง configuration file
cat > claude-config.json << EOF
{
  "project_name": "sql-training-journey",
  "database": {
    "type": "postgresql",
    "connection": "postgresql://student:securepass123@localhost:5432/training",
    "schemas": ["training_data", "staging", "analytics", "learning"]
  },
  "ai_assistance": {
    "code_generation": true,
    "documentation": true,
    "optimization": true,
    "testing": true
  },
  "output_preferences": {
    "format": "postgresql",
    "include_comments": true,
    "include_examples": true
  }
}
EOF
```

#### 🛠️ **Claude Code Workflow Setup**
```bash
# Initialize Claude Code in project
claude-code init --config claude-config.json

# Setup database schema inspection
claude-code db inspect --connection postgresql://student:securepass123@localhost:5432/training

# Generate initial project documentation
claude-code docs generate --output ./docs/
```

### 📅 **Phase 2: AI-Assisted Development** (สัปดาห์ 4+)

#### 🎯 **SQL Generation Workflow**
```bash
# Example: Generate complex query
claude-code sql generate \
  --task "Create a window function to rank customers by total purchase amount per year" \
  --schema "training_data" \
  --output "./exercises/window-functions/"

# Example: Optimize existing query
claude-code sql optimize \
  --file "./exercises/slow-query.sql" \
  --explain-plan \
  --suggestions "./solutions/"

# Example: Generate test data
claude-code data generate \
  --schema "training_data.sample_orders" \
  --rows 10000 \
  --output "./resources/datasets/test-orders.sql"
```

#### 📚 **Documentation Generation**
```bash
# Auto-generate documentation for SQL scripts
claude-code docs sql \
  --input "./week3-advanced/" \
  --output "./docs/sql-reference.md" \
  --include-examples

# Generate API documentation for stored procedures
claude-code docs procedures \
  --schema "analytics" \
  --format "markdown" \
  --output "./docs/procedures-api.md"
```

---

## 🔄 **Daily Workflow Process**

### 📋 **ขั้นตอนการทำงานร่วมกันแต่ละวัน**

#### 🌅 **เริ่มต้นวัน (5 นาที)**
1. **Pull latest changes**:
   ```bash
   git pull origin main
   ```

2. **Start Docker environment**:
   ```bash
   cd week0-docker
   docker-compose up -d
   ```

3. **Activate Claude Code session**:
   ```bash
   claude-code session start --project sql-training-journey
   ```

#### 📚 **ระหว่างการเรียน (Session Work)**

**ช่วงที่ 1-2: Learning + AI-Assisted Practice**
```bash
# Claude generates learning exercises
claude-code learning generate \
  --topic "window-functions" \
  --difficulty "intermediate" \
  --examples 5

# You practice with AI feedback
claude-code feedback \
  --solution "./my-solution.sql" \
  --expected "./exercises/window-functions/solution.sql"
```

**ช่วงที่ 3-4: Project Work + Documentation**
```bash
# Work on project with AI assistance
claude-code project assist \
  --task "create-etl-pipeline" \
  --context "./projects/real-world-integration/"

# Auto-generate commit messages
claude-code git commit-message \
  --files "./projects/real-world-integration/etl-pipeline.sql" \
  --context "Added customer data ETL pipeline with error handling"
```

#### 🌆 **สิ้นสุดวัน (10 นาที)**
1. **Document progress**:
   ```bash
   # AI helps generate daily summary
   claude-code summary generate \
     --date $(date +%Y-%m-%d) \
     --files-changed $(git diff --name-only HEAD~1) \
     --output "./docs/daily-progress/"
   ```

2. **Commit & Push**:
   ```bash
   git add .
   git commit -m "$(claude-code git commit-message --auto)"
   git push origin main
   ```

3. **Stop environment**:
   ```bash
   docker-compose stop
   claude-code session end
   ```

---

## 📊 **Progress Tracking System**

### 📈 **Automated Progress Tracking**
สร้างไฟล์ `docs/progress-tracking.md`:
```markdown
# SQL Training Progress Tracker

## Week 0: Docker Quick Start ✅
- [x] Docker installation and basic commands
- [x] PostgreSQL container setup
- [x] DBeaver integration
- [x] Backup/restore procedures

## Week 1: SQL Refresher 🔄
- [ ] Advanced filtering techniques
- [ ] JOINs refresher
- [ ] Set operators
- [ ] Pre-assessment completion

## AI Assistance Metrics
- **Queries generated**: 0
- **Code optimizations**: 0  
- **Documentation auto-generated**: 0
- **Errors caught by AI**: 0

## Daily Learning Hours
- Week 0: 6 hours
- Week 1: 0 hours
- Total: 6 hours

## Project Milestones
- [ ] Real-world Integration Project (Week 6)
- [ ] Data Warehousing Project (Week 12)
- [ ] Performance Optimization Project (Week 16)
```

### 🤖 **AI-Generated Reports**
```bash
# Weekly progress report
claude-code report weekly \
  --week $(date +%V) \
  --metrics "learning-hours,exercises-completed,ai-interactions" \
  --output "./docs/weekly-reports/"

# Skills assessment
claude-code assess skills \
  --based-on "./exercises/" \
  --compare-to "intermediate-level" \
  --recommendations "./docs/skill-gaps.md"
```

---

## 🛠️ **ขั้นตอนการทำงานร่วมกันระหว่าง Claude และคุณ**

### 📞 **การสื่อสารในแต่ละ Session**

#### 🎯 **เริ่มต้น Session**
**คุณพิมพ์**:
```
"สวัสดีครับ Claude พร้อมเริ่ม SQL training วันนี้แล้วครับ 
วันนี้เป็น [วันที่/สัปดาห์ที่เท่าไหร่] และผมจะเรียนเรื่อง [หัวข้อ]
ช่วยเตรียม exercises และ Claude Code commands ให้หน่อยครับ"
```

**Claude ตอบ**:
- สรุป agenda วันนี้
- เตรียม Claude Code commands
- ให้ pre-assessment (ถ้าจำเป็น)
- แจ้งขั้นตอนการทำงาน

#### 💡 **ระหว่าง Session**
**เมื่อคุณติดปัญหา**:
```
"ผมติดตรงนี้ครับ [อธิบายปัญหา] 
Claude Code ให้ error นี้: [copy error message]
ช่วยแนะนำหน่อยครับ"
```

**เมื่อต้องการ AI assistance**:
```
"ขอให้ Claude Code สร้าง [สิ่งที่ต้องการ] ให้หน่อยครับ
Context: [อธิบายสถานการณ์]
Requirements: [ความต้องการเฉพาะ]"
```

#### ✅ **สิ้นสุด Session**
**คุณพิมพ์**:
```
"เสร็จแล้วครับ วันนี้เรียนเรื่อง [หัวข้อ] 
ผลงานมี [สิ่งที่ทำเสร็จ]
ปัญหาที่เจอ [ปัญหา (ถ้ามี)]
พรุ่งนี้จะเรียนเรื่องอะไรครับ?"
```

**Claude ตอบ**:
- สรุปผลงานวันนี้
- แนะนำการ commit code
- เตรียม agenda พรุ่งนี้
- ให้คำแนะนำเพิ่มเติม

---

## 🔧 **Templates & Shortcuts**

### 📝 **Daily Commit Message Templates**
```bash
# Claude Code generates commit messages
claude-code git commit-message --template "sql-training" --format:
"feat(week{week}): {feature-description}

- Added: {what-was-added}
- Learned: {key-concepts}
- AI-assisted: {ai-contributions}

Progress: {completion-percentage}% of week {week}"
```

### 🤖 **AI Prompt Templates**
สร้างไฟล์ `week2-modern-setup/ai-prompts/templates.md`:
```markdown
# AI Prompt Templates

## SQL Generation
```
Generate a PostgreSQL query that:
- Task: {specific-task}
- Schema: {schema-name}
- Requirements: {business-requirements}
- Performance: Should be optimized for {performance-criteria}
- Output format: Include comments and explain the logic
```

## Code Review
```
Review this SQL code for:
- Correctness
- Performance optimization opportunities
- Best practices adherence
- Security considerations
- PostgreSQL-specific improvements

Code:
{your-sql-code}
```

## Documentation
```
Generate documentation for this SQL script:
- Purpose: {what-it-does}
- Input: {input-parameters}
- Output: {expected-results}
- Usage examples: Include 2-3 practical examples
- Performance notes: Any important performance considerations

Script:
{your-sql-script}
```
```

---

## 📅 **Schedule Integration**

### 🗓️ **Weekly Planning Session** (ทุกวันจันทร์)
```bash
# Generate weekly plan with Claude Code
claude-code plan weekly \
  --week $(date +%V) \
  --previous-progress "./docs/progress-tracking.md" \
  --curriculum "./README.md" \
  --output "./docs/weekly-plans/week-$(date +%V).md"
```

### 📊 **Monthly Review** (ทุกสิ้นเดือน)
```bash
# Comprehensive monthly report
claude-code report monthly \
  --month $(date +%m) \
  --include "progress,skills-gained,project-outcomes,ai-productivity" \
  --format "presentation" \
  --output "./docs/monthly-reviews/"
```

---

## 🎯 **Success Metrics & KPIs**

### 📈 **AI Productivity Metrics**
- **Code generation speed**: เวลาที่ใช้เขียน SQL ลดลง 60-80%
- **Error reduction**: Bug ลดลง 70% ด้วย AI review
- **Documentation coverage**: 95% ของ code มี documentation
- **Learning velocity**: เรียนเนื้อหาได้เร็วขึ้น 3-5 เท่า

### 🏆 **Weekly Milestones**
- **Week 2**: Claude Code integration complete
- **Week 4**: AI-assisted ETL pipeline
- **Week 8**: Automated documentation workflow
- **Week 12**: AI-optimized data warehouse
- **Week 16**: Production-ready AI workflow

---

*🤖 พร้อมเริ่มต้นการเรียนรู้ที่จะเปลี่ยนแปลงวิธีการทำงานของคุณแล้วไหม?*