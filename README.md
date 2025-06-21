# Technical Assessment - Flutter Developer Position

This repository contains a Flutter application developed as part of a technical assessment for a Flutter developer position. The app demonstrates features such as user authentication, real-time clock display, location-based check-in, and optical character recognition (OCR) for Emirates ID extraction.

---

## 📦 Setup Instructions

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/MHekmatF/technical_assessment.git
   cd technical_assessment
   ```

2. **Install Dependencies:**

   Ensure you have Flutter installed. Then, run:

   flutter pub get
   flutter pub run build_runner build

3. **Set Up Hive Database:**

   - Initialize Hive and register adapters in your main application file.

4. **Configure Permissions:**

   - **Android:** Update `AndroidManifest.xml` to request necessary permissions for location and storage access.
   - **iOS:** Modify `Info.plist` to include permission descriptions for location and camera access.

5. **Run the Application:**

   flutter run

---

## 📚 Libraries Used

- **Flutter SDK**: Framework for building natively compiled applications.
- **Hive**: Lightweight and fast key-value database for Flutter.
- **Google ML Kit**: Machine learning SDK for on-device processing, used for text recognition.
- **Geolocator**: Provides geolocation functionalities for determining device position.
- **Image Picker**: Allows users to pick images from the gallery or camera.
- **Permission Handler**: Simplifies permission requests for iOS and Android.

---

## ✅ Features & Testing

### 1. User Authentication

- **Feature**: User credentials are stored and retrieved using Hive.
- **Test**: Ensure that user data persists across app restarts.

### 2. Real-Time Clock

- **Feature**: Displays the current time, updating every second.
- **Test**: Verify that the time updates correctly and reflects the device's local time.

### 3. Location-Based Check-In

- **Feature**: Users can check in if they are within a specified radius of a predefined location.
- **Test**: Test by simulating different locations to ensure the check-in functionality works as expected.

### 4.  ID OCR Extraction

- **Feature**: Users can upload a photo of their Emirates ID, and the app extracts the name and ID number.
- **Test**: Upload various images with clear and unclear ID cards to test the accuracy and reliability of the OCR feature.

---

## 📝 Notes

- Ensure all required permissions are granted on the device for location and storage access.
- The app uses a timer to update the UI every second; ensure the device's time settings are correct.
- For OCR functionality, the quality of the uploaded image significantly affects the accuracy of data extraction.
