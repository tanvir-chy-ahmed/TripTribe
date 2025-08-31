# 🌍 TripTribe – Discover & Share the Best Places

**TripTribe** is your travel companion app—designed for explorers to **discover amazing places**, **share hidden gems**, and **connect with fellow travelers**. Whether you're planning an adventure or just browsing for inspiration, TripTribe brings the best of the world to your fingertips.

---

## ✨ Features
- 📌 **Discover Top Destinations** — Explore curated lists of must-visit spots.
- 📝 **Share Your Experiences** — Post descriptions, photos, and details of your favorite places.
- 💬 **Connect With Travelers** — Comment, follow, and exchange tips with a vibrant community.
- 🔍 **Smart Search & Categories** — Find spots by location or theme (nature, food, culture, adventure, etc.).
- ❤️ **Save Favorites** — Bookmark places you want to revisit or explore later.
- 🌐 **Community Driven** — Built by travelers, for travelers.

---

## 🖼️ Screenshots
*(Add screenshots or GIFs here to showcase your app UI)*

---

## ⚙️ Tech Stack
- **Frontend:** Flutter (cross-platform) / Jetpack Compose (Android-native)
- **Backend:** Supabase / Firebase / REST APIs
- **Database:** PostgreSQL (via Supabase) / Firestore
- **Authentication:** Supabase Auth / Firebase Auth / Google Sign-In
- **Extras:** Push Notifications, Maps Integration, Shared Preferences

---

## 📂 Project Structure / Pseudo Architecture

```plaintext
TripTribe/
│
├── android/                     # Android-specific native project files
├── assets/                      # Images, icons, fonts, and other assets
├── ios/                         # iOS-specific native project files
│
├── lib/                         # Main Flutter source code
│   ├── data/                    # Static data & constants
│   │   ├── ListsOfDatas.dart
│   │   └── countrystopplaces.dart
│   │
│   ├── navigationbar/           # Bottom navigation bar UI & logic
│   │   └── bnview.dart
│   │
│   ├── screens/                 # App UI Screens
│   │   ├── detailsscreen/       # Place details
│   │   │   └── DetailsScreen.dart
│   │   │
│   │   ├── explorescreen/       # Explore section
│   │   │   ├── country/
│   │   │   └── ExploreScreen.dart
│   │   │
│   │   ├── trendingscreen.dart  # Trending places UI
│   │   │
│   │   ├── homescreen/          # Home feed & posts
│   │   │   ├── post/
│   │   │   └── HomeScreen.dart
│   │   │
│   │   ├── onboard/             # Onboarding screens
│   │   │   └── controller/
│   │   │       ├── onboarding_s1.dart
│   │   │       ├── onboarding_s2.dart
│   │   │       └── onboarding_s3.dart
│   │   │
│   │   ├── profile/screen/      # User profile
│   │   │   ├── EditProfile.dart
│   │   │   └── ProfileScreen.dart
│   │   │
│   │   ├── shimmer/             # Loading placeholders
│   │   │   └── shimmer_card.dart
│   │   │
│   │   └── socialmedia/         # Social media features
│   │       ├── chat/            # Chat UI & logic
│   │       ├── components/      # Reusable components
│   │       ├── post/            # Post-related widgets
│   │       └── SocialMediaHome.dart
│   │
│   ├── supabase/                # Backend service setup
│   │   └── setup.dart
│   │
│   ├── util/                    # Utility files
│   │   ├── SplashScreen.dart
│   │   └── images.dart
│   │
│   └── main.dart                # App entry point
│
├── test/                        # Unit & widget tests
│
├── .gitignore                   # Git ignore rules
├── .metadata                    # Flutter project metadata
├── README.md                    # Project documentation
├── analysis_options.yaml        # Dart analysis & linter rules
├── devtools_options.yaml        # Devtools config
├── pubspec.lock                 # Locked dependency versions
└── pubspec.yaml                 # Flutter dependencies & assets
```



## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Supabase or Firebase project setup
- Android Studio or VS Code

### Installation
```bash
git clone https://github.com/tanvir-chy-ahmed/TripTribe.git
cd TripTribe
flutter pub get
flutter run
```

---

## 🤝 Contributing
Contributions are welcome!  
- Open an **issue** to suggest enhancements or report bugs.  
- Submit a **pull request** to add features, fix bugs, or improve the app.  

---

## 📜 License
This project is licensed under the **MIT License** — free to use, modify, and share.

---

## 💡 Inspiration
TripTribe was created to:  
- Make exploring the world more accessible and fun  
- Help people uncover hidden travel gems  
- Build a friendly, connected community of explorers  

---

## ⭐ Support
If you enjoy using TripTribe, please **star⭐ the repo** and share it with fellow travelers!

---

## 🔹 Optional: User Flow Diagram
```
[Login] --> [Explore] --> [Post] --> [Interact]
```
