# Doc Prescriptions

Doc prescriptions is an app to help doctors create prescriptions. It's an mvp app that can be extended to have QR code or downloadable and printable list of meds for the patient. This app uses cloud firebase to retrieve data from the internet as fast as possible. 

*Specifically designed for demo.The idea of doing an prescription app is based to the nature of client whick is in field of medicine. 

# Architecture & State Management
The app implements Getx Architecture, and uses the base Scaffold provided by Very Good Venture. During the development, the developer uses several code genration such as, Get CLI, Very Good CLI,  Build Runner.  The app initializes the repositories and controllers during initialization to efficiently use the singleton for each class, then the getx finds the classes and its in instance when it is needed.

# State Management
The developer used GetX as this is the main statemanagement used by the client, GetX was ustilized at all ways such as using GetxRoute, Binding, managing business logic, State management, and GetStorage for persistent Data.

# Doc Prescriptions
A demo app made from Flutter, and Firebase for Backend.
    - Firebase Authentication
    - FireStore CRUD(create, read, update, delete)
    - Search 
    - Sort
    - Platform agnostic Packages
    - GetX clean architecture
    - Flavors, Envirnoment
    - Use of Faker Data
    - Video Player
    - Pageview


## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

If you need to build a release version, you need the the key properties to prodcue the release version which the developer will provide.

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart
$ flutter build apk --release --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

