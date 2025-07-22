# 📝 TASK Tool

**TASK Tool** is a simple and modular SwiftUI application for creating and listing tasks, integrated with a RESTful backend API.

## 🚀 Features

- ✅ Create and list tasks from a remote API
- 🧱 Built with **SwiftUI** using a clean and scalable architecture
- 🧩 Uses the **Repository Pattern** for data handling
- 🧠 Follows the **MVVM (Model-View-ViewModel)** architectural pattern
- 🔄 Supports dependency injection
- 🌐 Network layer abstraction using a custom-built API client
- 🔌 Local mock repository for testing and preview purposes
- 🌗 Full support for **Light and Dark Mode**

## 🧠 Architecture

This project follows a modular architecture with clear separation of concerns:

### MVVM Pattern

- **Model**: Defines data structures and API responses
- **ViewModel**: Handles business logic and state management
- **View**: SwiftUI views observe `@Published` properties for reactive updates

### Repository Layer

- Abstracts data access logic via the `TaskRepository` protocol
- Includes:
  - **RemoteTaskRepository**: communicates with the backend API
  - **MockTaskRepository**: simulates local data (for testing and preview)

### Dependency Injection

- Injects the appropriate repository into SwiftUI views
- Enables easy switching between mock and live data sources

### Networking Layer

- Built from scratch to communicate with the backend RESTful API
- Includes:
  - `RequestBuilder`: builds and configures URL requests
  - `APIClient`: handles the request/response cycle
  - `APIRequest`: defines the endpoint configuration
  - `HTTPMethod`, `Parameters`, and `NetworkLogger` utilities for clean and flexible networking

## 📦 Dependencies

This project does not rely on external libraries for networking or architecture — all logic is built natively using **Swift** and **SwiftUI**.

## 📱 Screens

- **Task List View**: Displays all tasks fetched from the API
- **Create Task View**: Allows creating new tasks and posting them to the backend
- Fully responsive to system **Light and Dark Mode** settings
