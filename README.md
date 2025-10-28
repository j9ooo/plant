
🌱 PlantsApp: Your Smart Plant Care Companion

Overview

plantsApp** is a beautifully designed, native iOS application built entirely with **SwiftUI** to simplify and gamify daily plant care. It moves beyond simple reminder lists, utilizing a dynamic tracking system that gives users real-time feedback on their progress, ensuring their plants stay happy and healthy.

The app is engineered using the **MVVM (Model-View-ViewModel)** architectural pattern, providing a clean separation between the UI and business logic, which enhances stability and maintainability.



 ✨ Core Features and Functionality

 Dynamic Daily Tracking (Today Reminder View)**

The main screen provides a clear overview of daily responsibilities:

Visual Progress Bar:** A dynamic progress bar at the top of the screen visually updates as tasks are completed, motivating the user towards full completion.
Intelligent Header Messages:** The app provides contextual, encouraging text feedback based on the status of the day's tasks, managed by the `headerText` computed property:
 "Your plants are waiting for a sip 💦"** (When $0\%$ complete)
   "3 of your plants feel loved today ✨"** (When partially complete)
 "All plants feel loved today! Great job! ✨"** (Upon 100% completion)
Quick Check-off:** Users can easily tap the checkmark icon on any list item to instantly update its status.

Seamless Completion Flow & Congratulation**

A key feature is the automated transition after successful completion:

 Once the **Progress Bar** reaches $100\%$ (i.e., `allRemindersCompleted` is true), the app automatically navigates the user back to the **Starter/Welcome View**.
 This transition serves as a **congratulations screen**, simultaneously **clearing all completed reminders** (`viewModel.reminders.removeAll()`) to reset the app state for the next care cycle.

Intuitive Reminder Management

The floating **(+)** button allows users to set new plant reminders via a modal sheet (`SetReminderView`).
The setup process is detailed, covering necessary parameters like **Plant Name**, **Room**, **Light Requirements**, **Watering Schedule**, and the specific **Water Amount** needed.
Full data management capabilities are supported, including swipe-to-delete on list items and detailed editing via the `PlantDetailView`.



 ⚙️ Technical Highlights

The application's logic is primarily driven by the central **`ReminderListViewModel`** (`ObservableObject`).

**State Management:** The ViewModel manages the `reminders` array (`@Published`), ensuring the entire UI (`TodayReminderView` and `ContentView`) reacts immediately and automatically to any changes (like checking off a plant or adding a new one).
 **Architecture:** The entire navigation flow—switching between the initial welcome state and the active daily tracking state—is managed through **conditional rendering** within the main `ContentView.swift` file, making transitions efficient and controlled.
 **SwiftUI:** The UI leverages modern SwiftUI features, including `NavigationStack`, `.sheet` for modals, and the powerful `.onChange()` modifier to monitor the `allRemindersCompleted` state and trigger the post-completion automated navigation.
