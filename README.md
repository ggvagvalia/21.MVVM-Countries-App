# Countries Info App

This project is an iOS application built using UIKit, and MVVM architecture. It fetches country information using the RestCountries API and displays it in a user-friendly format. The app supports Dark/Light modes, user authentication using Keychain, and allows users to set custom profile images.

<img width="250" alt="Screenshot 2024-09-23 at 6 22 12 PM" src="https://github.com/user-attachments/assets/ce589616-ba8e-4256-9c21-314abef24405">
<img width="250" alt="Screenshot 2024-09-23 at 6 22 49 PM" src="https://github.com/user-attachments/assets/99db7990-1185-414c-a551-8db54a697e44">
<img width="250" alt="Screenshot 2024-09-23 at 6 22 35 PM" src="https://github.com/user-attachments/assets/0ddbc153-e05e-4029-af80-dccf74af8837">

<img width="247" alt="Screenshot 2024-09-23 at 6 23 23 PM" src="https://github.com/user-attachments/assets/48f89a62-b6a0-4e69-873a-b6dca5c400e0">
<img width="247" alt="Screenshot 2024-09-23 at 6 23 11 PM" src="https://github.com/user-attachments/assets/83575729-fca9-4455-b9c9-e3af10a06b85">

<img width="300" alt="Screenshot 2024-09-23 at 6 23 59 PM" src="https://github.com/user-attachments/assets/83122f99-e2ea-43b0-b319-774713286679">
<img width="300" alt="Screenshot 2024-09-23 at 6 23 42 PM" src="https://github.com/user-attachments/assets/ce7895b7-9a96-4fb9-b123-419c98febccd">



### Features

UITableView and UIScrollView Usage: The app displays country lists and detailed information using UITableView and UIScrollView, offering a smooth and intuitive experience.
RestCountries API Integration: The app fetches country data from the RestCountries API, including flags, country names, regions, and other information.

MVVM Architecture: The app uses the Model-View-ViewModel (MVVM) architectural pattern to separate business logic from the UI layer, ensuring maintainability and testability.

Dark/Light Mode Support: The app fully supports both Dark and Light modes, automatically adjusting to the system's appearance settings.

Search by Country: Users can search for a country using the search bar, making it easier to find specific information quickly.

### Authentication and Keychain Features

Keychain Integration:
Upon first login, the app stores the username and password securely in the Keychain.
On subsequent launches, the app automatically authenticates the user using the stored Keychain data.

First-Time Login Alert: 
When a user logs in for the first time, the app displays a friendly greeting using an alert.

UserDefaults:
A Bool flag is stored in UserDefaults to track whether the user is logging in for the first time.

### Additional Features

Profile Image Setting: Users can select a profile image from their device’s gallery by tapping the "Set Image" button. Once selected:
The image is displayed in place of the button.
The image is saved in the app’s Documents directory using FileManager.

### API

RestCountries API: The app interacts with the RestCountries API to fetch country data, including flags, names, and more. You can find more about the API here.

