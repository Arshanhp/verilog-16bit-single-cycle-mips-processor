# 🏛️ 16-bit Single-Cycle MIPS Processor Design
> **طراحی و پیاده‌سازی سخت‌افزاری پردازنده ۱۶ بیتی MIPS در محیط Verilog با معماری Accumulator-Based**

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-orange?style=for-the-badge&logo=verilog" />
  <img src="https://img.shields.io/badge/Architecture-MIPS_RISC-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Memory-4K_x_16bit-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Type-Single--Cycle-red?style=for-the-badge" />
</p>

---

### 🌐 مستندات و گزارش کامل فنی
> [!IMPORTANT]
> **برای مشاهده تحلیل دقیق سیگنال‌ها، دیاگرام‌های زمان‌بندی (Waveforms) و داکیومنت تعاملی پروژه روی لینک زیر کلیک کنید:**
> ### 🔗 [مشاهده گزارش کامل پروژه (GitHub Pages)](https://arshanhp.github.io/verilog-16bit-single-cycle-mips-processor/)

---

## 💎 ویژگی‌های شاخص معماری (Technical Specifications)

*   **⚡ واحد پردازش:** طراحی Single-Cycle با گذردهی یک دستور در هر پالس ساعت (CPI=1).
*   **💾 فایل رجیستر:** شامل ۸ رجیستر ۱۶ بیتی (R0 تا R7) که در آن **R0 نقش Accumulator** را ایفا می‌کند.
*   **🏗️ فضای آدرس‌دهی:** توانایی مدیریت حافظه با ظرفیت **4K x 16-bit**.
*   **🛠️ تنوع دستورات:** پشتیبانی از ۴ قالب دستورالعمل (Type A, B, C, D) برای مدیریت بهینه Opcode و Data.

---

## 🗺️ ساختار قالب دستورات (Instruction Formats)

در این معماری، دستورات ۱۶ بیتی به ۴ روش تفسیر می‌شوند:

| Type | Bit 15-12 | Bit 11-9 | Bit 8-0 / 11-0 | توضیحات |
| :--- | :---: | :---: | :---: | :--- |
| **Type A** | Opcode | - | Adr (12-bit) | دستورات Load, Store, Jump |
| **Type B** | Opcode | Ri | Adr (9-bit) | دستور پرش شرطی BranchZ |
| **Type C** | Opcode | Ri | Func (9-bit) | عملیات‌های ALU و جابجایی رجیستر |
| **Type D** | Opcode | - | Imm (12-bit) | محاسبات مستقیم با مقدار Immediate |

---

## 📊 جدول مجموعه دستورالعمل‌ها (ISA)

| Mnemonic | Operation | Opcode | Function | Type |
| :--- | :--- | :---: | :---: | :---: |
| **Load** | `R0 <- M[adr-12]` | `0000` | - | A |
| **Store** | `M[adr-12] <- R0` | `0001` | - | A |
| **Jump** | `PC <- adr-12` | `0010` | - | A |
| **BranchZ**| `if (R0==Ri) PC[8:0] <- adr-9` | `0100` | - | B |
| **Add** | `R0 <- R0 + Ri` | `1000` | `000000100` | C |
| **Sub** | `R0 <- R0 - Ri` | `1000` | `000001000` | C |
| **MoveTo** | `Ri <- R0` | `1000` | `000000001` | C |
| **Addi** | `R0 <- R0 + Imm12` | `1100` | - | D |

---

## ⚙️ واحد محاسبات و منطق (ALU Operations)
واحد ALU این پردازنده عملیات‌ها را بر اساس کد عملیاتی ۳ بیتی به شرح زیر پردازش می‌کند:

| Op-Code | Operation (y) | Description |
| :---: | :--- | :--- |
| `000` | `In1 + In2` | Addition |
| `001` | `In1 - In2` | Subtraction |
| `010` | `In1 & In2` | Bitwise AND |
| `011` | `In1 \| In2` | Bitwise OR |
| `100` | `~In1` | Bitwise NOT |
| `101` | `In1` | Transfer In1 |
| `110` | `In2` | Transfer In2 |

---

## 📂 ساختار درختی پروژه
```bash
├── 📁 single_cycle                   # سورس کدهای Verilog
│   ├── alu.v                # واحد محاسبات و منطق (ALU)
│   ├── control_unit.v       # واحد کنترل مرکزی
│   ├── register_file.v      # بانک رجیسترهای R0-R7
│   ├── instruction_memory.v # حافظه ROM دستورات
│   ├── data_memory.v        # حافظه RAM داده‌ها
│   └── processor.v          # ماژول مرجع (Top-Level)
├── 📝 program.hex           # برنامه تست (کد ماشین)
└── 🌐 index.html            # گزارش فنی تعاملی پروژه
