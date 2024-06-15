# Giphy App with Login/Signup and Favorites



**Project Description**: This project is a Giphy App that allows users to search for GIFs, view trending GIFs, authenticate with a login/signup feature, and favorite GIFs.

## Features

1. **Search and Trending GIFs:**
   - Implemented a search bar to search for GIFs using the Giphy API.
   - Displays trending GIFs when the search bar is empty.

2. **Search Results:**
   - Updates the view with relevant GIF search results as the user types a search term.
   - Implemented pagination or infinite scroll for the search results.

3. **User Authentication:**
   - Implemented user authentication with Login and Signup screens.
   - Used Firebase Authentication to securely manage user accounts.

4. **Favorites Feature:**
   - Authenticated users can favorite GIFs.
   - Implemented a section to display favorite GIFs for each user.

## Technologies Used

- **MVVM Pattern**: Separates business logic from the UI, enhancing maintainability and testability.
- **GetX State Management**: Lightweight, reactive state management solution for Flutter applications, with dependency injection and routing capabilities.
- **Firebase Authentication**: Securely manages user authentication and accounts.
- **Retrofit**: Type-safe HTTP client for making API calls and handling responses.
- **Dio**: Powerful HTTP client for Dart and Flutter applications, simplifying network requests.

## Screenshots & Video
Google Drive Demo Video and Screenshots: https://drive.google.com/drive/folders/1WC0kqy73kkXVqqPf3pdol96Gfyo9zD47?usp=sharing


## Setup

To run this project locally, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your/repository.git
   cd repository-name
   ```

2. **Setup Firebase:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Add your Flutter app to the Firebase project.
   - Download and add the `google-services.json` file to the `android/app` directory (for Android) or `GoogleService-Info.plist` file to the `ios/Runner` directory (for iOS).

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Future Improvements

- Implement a detailed view for GIFs with options to share and download.
- Enhance the favorites feature with sorting and filtering options.
- Implement user profiles with additional features such as settings and profile management.

