# 🏛️ 16-bit Single-Cycle MIPS Processor Design
> **طراحی و پیاده‌سازی سخت‌افزاری پردازنده ۱۶ بیتی MIPS در محیط Verilog**

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-orange?style=for-the-badge&logo=verilog" />
  <img src="https://img.shields.io/badge/Architecture-MIPS_RISC-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Simulation-ModelSim-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Type-Single--Cycle-red?style=for-the-badge" />
</p>

---

### 🌐 مستندات و گزارش کامل فنی
> [!IMPORTANT]
> **برای مشاهده گزارش کامل، تحلیل سیگنال‌ها، دیاگرام‌های زمان‌بندی و داکیومنت تعاملی پروژه روی لینک زیر کلیک کنید:**
> ### 🔗 [مشاهده گزارش کامل پروژه (GitHub Pages)](https://arshanhp.github.io/verilog-16bit-single-cycle-mips-processor/)

---

## 💎 ویژگی‌های شاخص معماری (Core Features)
این پردازنده صرفاً یک طرح تئوری نیست؛ بلکه یک معماری دقیق با ویژگی‌های زیر است:

*   **⚡ طراحی Single-Cycle:** اجرای هر دستورالعمل دقیقاً در یک پالس ساعت (CPI = 1).
*   **🏗️ معماری Harvard:** جداسازی کامل مسیر حافظه دستورات (Instruction) از حافظه داده (Data) برای حذف Structural Hazard.
*   **💾 سیستم Accumulator-Based:** استفاده از رجیستر **R0** به عنوان **ACC** برای بهینه‌سازی محاسبات سریع.
*   **🚀 ISA منعطف:** دارای ۱۶ دستورالعمل پایه در ۴ قالب مختلف (Type A-D) که طیف وسیعی از عملیات‌ها را پوشش می‌دهد.

---

## 🛠️ کالبدشکافی مسیر داده (Datapath Analysis)
در این طراحی، داده‌ها از ۶ ایستگاه حیاتی عبور می‌کنند تا یک دستورالعمل تکمیل شود:

1.  **Instruction Fetch (IF):** خواندن دستور از حافظه ۴ کیلوبایتی بر اساس `PC`.
2.  **Decode:** خرد کردن دستور ۱۶ بیتی به Opcode، شماره رجیستر و مقادیر Immediate.
3.  **Register Access:** فراخوانی داده‌ها از Register File (شامل ۸ رجیستر ۱۶ بیتی).
4.  **Execute (ALU):** قلب تپنده پردازنده که عملیات ریاضی و منطقی را با دقت نانوثانیه انجام می‌دهد.
5.  **Memory Access:** تعامل با حافظه داده در دستورات `Load` و `Store`.
6.  **Write Back:** بازنویسی نتیجه نهایی در رجیستر هدف جهت استفاده در محاسبات بعدی.

<p align="center">
  <img src="images/datapath.png" width="800" alt="MIPS Datapath Diagram">
  <br><i>نمای شماتیک مسیر جریان داده و سیگنال‌های کنترلی</i>
</p>

---

## 📊 جدول مجموعه دستورالعمل‌ها (ISA)

| دستور | نوع | عملکرد | Opcode |
| :--- | :---: | :--- | :---: |
| `Load / Store` | **A** | انتقال داده بین حافظه و آکومولاتور | `0000/0001` |
| `Jump` | **A** | پرش بدون شرط به آدرس ۱۲ بیتی | `0010` |
| `BranchZ` | **B** | پرش شرطی (اگر ACC == Ri) | `0100` |
| `Add / Sub / And / Or` | **C** | محاسبات رجیستر با آکومولاتور | `1000` |
| `Addi / Andi / Ori` | **D** | محاسبات مستقیم با مقدار Immediate | `1100-1111` |

---

## 🧪 نتایج شبیه‌سازی (Simulation Results)
صحت عملکرد پردازنده با یک **Self-Checking Testbench** و اجرای برنامه `program.hex` در محیط **ModelSim** تایید شده است.

### تحلیل Waveform:
- **نظم PC:** افزایش خطی و پرش‌های صحیح در حلقه‌ها (Looping).
- **پایداری ALU:** انجام محاسبات پیچیده و انتقال نتایج به `WriteBack` بدون تاخیر غیرمجاز.
- **تست نهایی:** موفقیت در اجرای حلقه و رسیدن رجیستر R1 به مقدار `000A`.

<p align="center">
  <img src="images/waveform.png" width="900" alt="ModelSim Waveform Analysis">
</p>

---

## 📂 ساختار فایل‌های پروژه
```bash
├── 📁 src                   # سورس کدهای Verilog
│   ├── alu.v                # واحد محاسبات و منطق
│   ├── control_unit.v       # مغز متفکر و صادرکننده سیگنال‌ها
│   ├── register_file.v      # بانک ۸ تایی رجیسترها
│   ├── instruction_memory.v # حافظه دستورات (ROM)
│   ├── data_memory.v        # حافظه داده (RAM)
│   └── processor.v          # ماژول Top-Level برای اتصال نهایی
├── 📝 program.hex           # کد ماشین (تست کامل دستورات)
└── 🌐 index.html            # گزارش فنی تعاملی
