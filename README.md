# 🚀 16-bit Single-Cycle MIPS Processor

<p align="center">
  <img src="https://img.shields.io/badge/Verilog-F06633?style=for-the-badge&logo=verilog&logoColor=white" />
  <img src="https://img.shields.io/badge/Architecture-MIPS-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" />
</p>

---

### 🌐 Documentation & Live Preview
> [!IMPORTANT]
> **برای مشاهده گزارش کامل پروژه، تحلیل سینال‌ها و دیاگرام‌های فنی روی لینک زیر کلیک کنید:**
> ### 🔗 [مشاهده مستندات و گزارش کامل پروژه (Live Report)](https://arshanhp.github.io/verilog-16bit-single-cycle-mips-processor/)

---

## 📖 معرفی پروژه
این پروژه طراحی و پیاده‌سازی یک پردازنده **16 بیتی Single-Cycle** بر پایه معماری **MIPS** است. طراحی به صورت ماژولار در Verilog انجام شده و تمامی مراحل از **Fetch** تا **Write Back** در یک چرخه ساعت انجام می‌شود.

### ✨ ویژگی‌های کلیدی
- 🏗️ **معماری:** Single-Cycle MIPS-like
- 🔢 **طول داده:** 16-bit
- 🗄️ **فایل رجیستر:** دارای 8 رجیستر عمومی (R0 به عنوان Accumulator)
- 🧠 **حافظه:** 4KB Instruction Memory + Data Memory (Harvard Architecture)
- ⚡ **واحد پردازش (ALU):** پشتیبانی از عملیات ریاضی و منطقی (ADD, SUB, AND, OR, NOT, etc.)

---

## 🛠️ ساختار دستورالعمل‌ها (ISA)
این پردازنده از 4 قالب دستوری (Type A, B, C, D) پشتیبانی می‌کند:

| Type | Description | Usage |
| :---: | :--- | :--- |
| **A** | Memory/Jump | `Load`, `Store`, `Jump` |
| **B** | Branch | `BranchZ` (Conditional Jump) |
| **C** | Register-Register | `Add`, `Sub`, `And`, `Move`, `Not` |
| **D** | Immediate | `Addi`, `Subi`, `Andi`, `Ori` |

---

## 📂 ساختار فایل‌های پروژه
```bash
├── 📁 single_cycle          # کدهای منبع Verilog
│   ├── alu.v               # واحد محاسبات و منطق
│   ├── control_unit.v      # واحد کنترل
│   ├── register_file.v     # مدیریت رجیسترها
│   ├── data_memory.v       # حافظه داده
│   └── processor.v         # ماژول اصلی (Top Module)
├── 📝 program.hex          # کد ماشین برای تست برنامه
└── 🌐 index.html           # گزارش کامل فنی (GitHub Pages)
