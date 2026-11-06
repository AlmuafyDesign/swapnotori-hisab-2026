# স্বপ্নতরী — হিসাব ব্যবস্থাপনা

স্বপ্নতরী শেয়ার ভিত্তিক ব্যবসা প্রতিষ্ঠানের জন্য বাংলা, মোবাইল-উপযোগী ওয়েব অ্যাপ ও PWA। ফ্রন্টএন্ড HTML/CSS/Vanilla JavaScript; প্রকাশ Firebase Hosting-এ, ডেটাবেস Google Sheets ও Google Apps Script-এ।

## প্রস্তুত অংশ

- রেফারেন্স ছবির গাঢ় সবুজ সাইডবার ও পরিচ্ছন্ন আর্থিক ড্যাশবোর্ডের বাংলা বিন্যাস।
- ড্যাশবোর্ড, সদস্য, মাসিক/বার্ষিক চাঁদা, করজে হাসানা, ঋণ ফেরত, বিনিয়োগ, আয়, লাভ-লোকসান, রসিদ, রিপোর্ট ও সেটিংসের নেভিগেশন।
- “আমাদের সম্পর্কে” পৃষ্ঠায় আপনার দেওয়া সংবিধান এবং করজে হাসানার নিয়ম।
- Apps Script-এ Sheets-এর পৃথক লেজার, একক প্রশাসক যাচাই, ৬ ঘণ্টার session, সার্ভার-সাইড যাচাই এবং audit log-এর ভিত্তি।
- বাস্তব সার্ভার যুক্ত না হওয়া পর্যন্ত কোনো আর্থিক অঙ্ক বা সফল লেনদেন দেখায় না।

এখনও Google Sheet, Apps Script deployment, Firebase project, GitHub repository বা লাইভ ডেটা সংযুক্ত হয়নি। তাই বর্তমান ফাইলগুলোকে production-ready live আর্থিক অ্যাপ বলা যাবে না।

## Google Sheets ও Apps Script সেটআপ

1. Google Sheets-এ নতুন ফাঁকা spreadsheet তৈরি করুন। আপনার অনুমতিতে প্রস্তুত করা `private-import/workbook-import.json` অ্যাডমিন প্রবেশের পর **সেটিংস → আগের হিসাব আমদানি** থেকে বেছে নিন। এই ফাইলে ২৫ সদস্য ও মাসিক/বার্ষিক পুরোনো জমা আছে; এটি GitHub-এ যাবে না।
2. spreadsheet-এর **Extensions → Apps Script** খুলে `gas/Code.gs`-এর কোড সম্পূর্ণভাবে সম্পাদকে বসান।
3. **Project Settings → Script Properties**-এ `SPREADSHEET_ID` ও `ADMIN_EMAIL` যোগ করুন। `ADMIN_EMAIL` হবে ব্যবহারকারীর নির্দিষ্ট একমাত্র Gmail ঠিকানা।
4. `configureAdmin` একবার চালান। Apps Script-এর dialog-এ নিজে ১৪ বা তার বেশি অক্ষরের পাসওয়ার্ড দিন; password বা plaintext sheet-এ রাখা হবে না, শুধু salt ও hash থাকবে।
5. `doPost`/`doGet`-সহ Web app deploy করুন; **Execute as: Me** এবং **Who has access: Anyone**। অ্যাপ নিজস্ব server-side admin যাচাই করে। নতুন deployment URL `config.js`-এর `gasUrl`-এ বসান।
6. নতুন Apps Script deployment করলে URL বদলাতে পারে; `config.js` আপডেট করে Firebase Hosting আবার deploy করুন।

## Firebase Hosting

1. Firebase Console-এ নতুন project তৈরি করে Hosting চালু করুন।
2. Node.js ও npm প্রস্তুত থাকলে `npm install -g firebase-tools` চালান। এরপর `firebase login`, `firebase use --add`, `firebase deploy --only hosting` চালান।
3. Hosting প্রকাশের পর Firebase HTTPS লিংকে ডেস্কটপ/মোবাইল, PWA ইনস্টল এবং Apps Script সংযোগ যাচাই করুন।

## তথ্যের গোপনীয়তা ও নিরাপত্তা

- GitHub repository Private রাখুন। সদস্যদের আর্থিক তথ্য, spreadsheet ID, Apps Script credential, পাসওয়ার্ড বা session token commit করবেন না।
- `config.js`-এ শুধু Apps Script deployment URL থাকবে; এটি কোনো গোপন কী নয়।
- Session শুধু বর্তমান ট্যাবের স্মৃতিতে থাকে; browser storage ব্যবহার করা হয় না।
- Offline-এ অ্যাপের খোলস দেখা যেতে পারে; সার্ভারের সফল উত্তরের আগে কোনো আর্থিক লেনদেন নিশ্চিত হবে না।

## PWA ব্যবহার

Firebase HTTPS লিংকে Chrome-এর **Install app** থেকে কম্পিউটার বা Android-এ PWA ইনস্টল করুন। `config.js`-এর `gasUrl` ফাঁকা থাকলে সার্ভারের তথ্য ও সংরক্ষণ কাজ করবে না।
