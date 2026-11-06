# স্বপ্নতরী — হিসাব ব্যবস্থাপনা

বাংলা, মোবাইল-উপযোগী হিসাব অ্যাপ ও PWA। ফ্রন্টএন্ড HTML/CSS/Vanilla JavaScript; ডেটাবেসের নকশা Google Sheets ও Google Apps Script-ভিত্তিক।

## বর্তমান অবস্থা

- Firebase Hosting-এ অ্যাপ প্রকাশিত আছে: https://swapnotori-hisab-2026.web.app
- GitHub source repository: https://github.com/AlmuafyDesign/swapnotori-hisab-2026 (Private)
- “আমাদের সম্পর্কে” পাতায় সংবিধান ও করজে হাসানা নীতিমালা আছে।
- Google Apps Script web app URL সাইটে যুক্ত এবং private Google Sheet-এ ১৪টি হিসাব লেজার তৈরি হয়েছে। তবে লগইন যাচাইয়ের উত্তর frontend-এ ফেরার সমস্যা পাওয়া গেছে; Apps Script response forwarding fix এখনও live deployment-এ প্রকাশ হয়নি। আপডেট ও লগইন যাচাই না হওয়া পর্যন্ত আর্থিক ব্যবহার করবেন না।
- পুরোনো workbook-এর হিসাব এখনো আমদানি করা হয়নি; import না হওয়া পর্যন্ত লাইভ সাইটে পুরোনো সদস্য বা লেনদেন দেখা যাবে না।
- পুরোনো workbook-এর আমদানি ফাইল `private-import/`-এ স্থানীয়ভাবে রাখা আছে। `.gitignore`-এর কারণে এটি GitHub-এ নেই; Firebase Hosting-এও প্রকাশিত হয়নি।

## নিরাপত্তা ও আমদানি

- `config.js`-এ Apps Script API URL আছে; প্রতিটি ডেটা অনুরোধের আগে server-side administrator session যাচাই হয়।
- ব্যক্তিগত workbook import file source repository ও Hosting-এর public directory-তে নেই।
- Import করতে লাইভ অ্যাপে প্রশাসক হিসেবে প্রবেশ করে **সেটিংস → আগের হিসাব আমদানি** থেকে স্থানীয় `private-import/workbook-import.json` বেছে নিন। Import শেষ হলে সদস্যসংখ্যা ও লেনদেনের মোট যাচাই করুন।
- GitHub repository Private রাখুন। passwords, session tokens, spreadsheet data বা credentials commit করবেন না।

## প্রকাশ

```powershell
npx -y firebase-tools@latest deploy --only hosting --project swapnotori-hisab-2026
```

Hosting-এর public directory `site/`; এতে শুধু অ্যাপের static frontend ফাইল থাকে। `private-import/`, মূল workbook, ও Apps Script source প্রকাশিত site directory-তে নেই।
