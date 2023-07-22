# RenTa

RenTa is a user-friendly mobile application developed using Flutter and Firebase that empowers users to list their items for rent and connect with others who are interested in renting those items. Whether you have tools, equipment, electronics, or any other item that you'd like to share with the community, RenTa makes the process seamless and convenient.

## Features

- **List Your Items:** Easily create listings for your items with detailed descriptions, photos, and rental rates.

- **Browse Listings:** Explore a wide range of items available for rent in your area, and filter based on categories and location.

- **Renting Made Simple:** Contact the item owner through the app and finalize the rental process effortlessly.

## Tech Stack

RenTa is built with the following technologies:

- **Flutter:** Flutter is a powerful open-source UI software development kit created by Google. It allows developers to build natively compiled applications for mobile, web, and desktop from a single codebase. Website: [https://flutter.dev](https://flutter.dev)

- **Firebase:** Firebase is a comprehensive mobile and web application development platform provided by Google. It offers various services such as authentication, real-time database, cloud storage, and more, making it an excellent backend solution for RenTa. Website: [https://firebase.google.com](https://firebase.google.com)

## Setup

To set up RenTa on your local machine for development and testing purposes, follow the steps below:

### Prerequisites

- Flutter SDK: Make sure you have Flutter SDK installed on your system. You can download it from the official Flutter website: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

- Android Studio / Xcode: Install Android Studio or Xcode depending on whether you want to develop for Android or iOS.

- Flutter Dependencies: Run `flutter doctor` in the terminal to check if any additional dependencies are required for your development environment.

### Installation

1. Clone the RenTa repository from GitHub:

2. Navigate to the project directory:

```
cd renta
```

3. Fetch the required dependencies:

```
flutter pub get
```

4. Set up Firebase for RenTa (If you want to setup your own firebase server):

   - Create a new project on the [Firebase Console](https://console.firebase.google.com/).

   - Follow the instructions to add both Android and iOS apps to your Firebase project.

   - Download the `google-services.json` file for Android and `GoogleService-Info.plist` file for iOS.

   - Place the files in the respective app directories (e.g., `android/app` for Android and `ios/Runner` for iOS).

5. Run the app on your desired emulator or physical device:

```
flutter run
```

If all the steps were followed correctly, the RenTa app should now be running on your device or emulator.

## Contributing

We welcome contributions from the community to enhance the RenTa app further. If you'd like to contribute, please follow these guidelines:

1. Fork the RenTa repository to your GitHub account.

2. Create a new branch with a descriptive name for your feature or bug fix.

3. Make your changes and ensure that the code is properly formatted.

4. Write tests for new features or bug fixes to maintain code quality.

5. Submit a pull request with a detailed explanation of your changes.

## Feedback and Support

For any feedback, suggestions, or issues related to RenTa, please [open an issue](https://github.com/yourusername/RenTa/issues) on the GitHub repository. We appreciate your input and will do our best to provide timely support.

## License

RenTa is released under the [MIT License](LICENSE). You are free to use, modify, and distribute the app as per the terms of the license.

---

Thank you for choosing RenTa! We hope you find it useful for renting and sharing items in your community. If you encounter any problems or have any questions, feel free to reach out to us. Happy renting!
