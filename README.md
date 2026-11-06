# স্বপ্নতরী — হিসাব ব্যবস্থাপনা

বাংলা, মোবাইল-উপযোগী হিসাব অ্যাপ ও PWA। ফ্রন্টএন্ড HTML/CSS/Vanilla JavaScript; লাইভ হিসাবের ডেটা সমিতির Google Sheet-এ এবং API Google Apps Script-এ থাকে।

## প্রকাশিত সাইট

- GitHub Pages: https://almuafydesign.github.io/swapnotori-hisab-2026/
- GitHub source: https://github.com/AlmuafyDesign/swapnotori-hisab-2026 (Private repository)
- `main` branch-এ পরিবর্তন হলে `.github/workflows/pages.yml` থেকে `site/` স্বয়ংক্রিয়ভাবে প্রকাশ হয়।

## ডেটা ও প্রবেশ

- সদস্য ও আর্থিক হিসাব Google Sheet-এ থাকে; এগুলো GitHub source বা Pages artifact-এ অন্তর্ভুক্ত নয়।
- Apps Script server administrator session যাচাই করে। Apps Script API endpoint public হলেও অর্থ সংক্রান্ত অনুরোধের জন্য বৈধ প্রশাসক session আবশ্যক।
- ব্যক্তিগত workbook import file `private-import/`-এ স্থানীয়ভাবে থাকে এবং `.gitignore`-এ বাদ। মূল `.xlsx`, import JSON, পাসওয়ার্ড বা session token প্রকাশ করবেন না।
- পুরোনো workbook এখনও আমদানি করা হয়নি।

## স্থানীয়ভাবে দেখা

`site/index.html` ফাইলটি ব্রাউজারে খুলুন অথবা যেকোনো static web server থেকে `site/` পরিবেশন করুন।
