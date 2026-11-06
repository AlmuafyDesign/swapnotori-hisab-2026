# স্বপ্নতরী — হিসাব ব্যবস্থাপনা

বাংলা, মোবাইল-উপযোগী হিসাব অ্যাপ ও PWA। ফ্রন্টএন্ড HTML/CSS/Vanilla JavaScript; ডেটাবেসের নকশা Google Sheets ও Google Apps Script-ভিত্তিক।

## বর্তমান অবস্থা

- Firebase Hosting-এ একটি **প্রিভিউ** প্রকাশিত আছে: https://swapnotori-hisab-2026.web.app
- GitHub source repository: https://github.com/AlmuafyDesign/swapnotori-hisab-2026 (Private)
- “আমাদের সম্পর্কে” পাতায় সংবিধান ও করজে হাসানা নীতিমালা আছে।
- লাইভ প্রিভিউতে এখনো Google Sheets বা Apps Script API যুক্ত হয়নি। তাই সদস্যের হিসাব দেখায় না এবং আর্থিক লেনদেন সংরক্ষণ করে না। এটিকে উৎপাদন-ব্যবহারের জন্য প্রস্তুত আর্থিক অ্যাপ হিসেবে ব্যবহার করবেন না।
- পুরোনো workbook-এর আমদানি ফাইল `private-import/`-এ স্থানীয়ভাবে রাখা আছে। `.gitignore`-এর কারণে এটি GitHub-এ নেই; Firebase Hosting-এও প্রকাশিত হয়নি।

## Sheets / Apps Script backend

1. Google Sheet-এ Apps Script editor খুলে `gas/Code.gs` বসান।
2. Apps Script **Project Settings → Script Properties**-এ `SPREADSHEET_ID` এবং একক `ADMIN_EMAIL` যোগ করুন।
3. Google-এর authorization screen-এ প্রয়োজনীয় Sheets/Drive access নিজে পর্যালোচনা ও অনুমোদন করুন। `configureAdmin` চালিয়ে কমপক্ষে ১৪ অক্ষরের পাসওয়ার্ড নিজে সেট করুন; পাসওয়ার্ড চ্যাটে বা কোডে লিখবেন না।
4. Web app deploy করে `Execute as: Me` এবং `Who has access: Anyone` বাছুন। Public endpoint-এ আর্থিক তথ্য প্রকাশ হয় না; প্রতিটি API অনুরোধে সার্ভার-সাইড administrator session যাচাই হয়।
5. deployment URL `config.js`-এর `gasUrl`-এ বসিয়ে Hosting আবার প্রকাশ করুন।
6. অ্যাপের প্রশাসক প্রবেশের পর Settings থেকে অনুমোদিত local import file বেছে নিন। ডেটা আমদানির আগে Sheet-এর ব্যক্তিগত sharing access যাচাই করুন।

## প্রকাশ

```powershell
npx -y firebase-tools@latest deploy --only hosting --project swapnotori-hisab-2026
```

Hosting-এর public directory `site/`; এতে শুধু অ্যাপের static frontend ফাইল থাকে। `private-import/`, মূল workbook, ও Apps Script source প্রকাশিত site directory-তে নেই।
