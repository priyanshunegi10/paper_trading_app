# 🚀 Crypto Paper Trading App

A premium, full-stack Flutter application designed to provide a realistic cryptocurrency trading experience without any financial risk. Powered by live, real-time market data, this paper trading simulator serves as the perfect environment for beginners to understand market dynamics and for experienced traders to backtest their strategies. Upon signing up, every user is instantly credited with a **$100,000 virtual starting balance** to buy, sell, track their profits and losses, and build their ultimate crypto portfolio in a completely safe and risk-free ecosystem.

---

## 📸 App Preview & Screenshots

<p align="center">
  <video src="https://github.com/user-attachments/assets/065726df-87d9-4fa8-a509-3d38b6885413" width="250" autoplay loop muted playsinline></video>
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/94ffe92e-519b-4329-bd60-cbd7a5e71cf2" width="220" title="Home Screen">
  <img src="https://github.com/user-attachments/assets/2dc14721-6ce9-492c-9da0-14a6fb4e4d9f" width="220" title="Market Screen">
  <img src="https://github.com/user-attachments/assets/0af24553-83f0-4760-9e82-dec772a2150c" width="220" title="Portfolio Screen">
  <img src="https://github.com/user-attachments/assets/d7492f99-b4ea-4631-81a9-66184fb3d3a4" width="220" title="Transaction Screen">
  <img src="https://github.com/user-attachments/assets/2f5aa790-c881-4859-95d9-a3657a5781a0" width="220" title="Profile Screen">
  <img src="https://github.com/user-attachments/assets/45d616f4-0c96-4808-9aed-ae097a83c4c5" width="220" title="Auth Screen">
</p>

---

## ✨ Key Features

- **🔐 Firebase Authentication**: Secure Sign-up and Login system using Email & Password.
- **📈 Real-time Market Data**: Fetches live prices and market data for the top 100+ cryptocurrencies using the CoinGecko API.
- **💰 Virtual Wallet**: New users are instantly credited with a $100,000 starting balance.
- **📂 Portfolio Management**: Track your holdings, monitor purchased quantities, and analyze your total profit/loss in real-time.
- **📜 Transaction History**: Generates a digital receipt for every trade, securely saved in the Firebase database.
- **🎨 Modern UI**: Features a premium Glassmorphism effect with beautiful dark and light theme gradients.
- **⚙️ Reset Account**: Allows users to completely reset their balance and portfolio back to the initial state if they face heavy losses.

---

## 🛠️ Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase Auth, Cloud Firestore
- **State Management**: Provider (Clean Architecture)
- **API**: CoinGecko Public API
- **Local Storage/Icons**: Flutter Launcher Icons, Google Fonts

---

## 🚀 Installation & Setup

**1. Clone the project:**
`git clone https://github.com/priyanshunegi10/paper_trading_app.git`

**2. Install dependencies:**
`flutter pub get`

**3. Firebase Setup:**
- Create a new project on the Firebase Console.
- Place the `google-services.json` (for Android) file inside the `android/app/` directory.
- Update the Firestore Rules (Read/Write only for authenticated users).

**4. Run the app:**
`flutter run --no-enable-impeller`

---

## 🛡️ Security Rules (Firestore)

This app implements production-level security rules to ensure that users cannot access or modify each other's data:

```javascript
match /users/{userId} {
  allow read, write: if request.auth != null && request.auth.uid == userId;
  match /{document=**} {
    allow read, write: if request.auth != null && request.auth.uid == userId;
  }
}
```

⭐ If you liked this project, don't forget to give it a Star!
