# Shell Script Library with User Authentication

## Project Overview

This project aims to create a **Shell Script Library Web Application** that allows users to store, manage, and execute shell scripts remotely on Linux systems via a unique URL. The website will provide:

- **User Authentication:** Users can register, log in, and store their custom shell scripts.
- **Shell Script Execution:** Each user will have a unique URL, e.g., `localhost/<userid>/script.sh`, that can be executed on a Linux system using `wget` or `curl | sh`.
- **MySQL Database:** User credentials and stored scripts will be managed in a MySQL database.
- **SMTP Email Feature:** The system will include email notifications for user registration, password resets, and script execution confirmations.
- **Dockerized Development:** Docker will be used to containerize the frontend, backend, and database, ensuring portability and easy deployment.

## Key Features

### 1. **User Authentication**
   - Users can register and log in to the platform.
   - Passwords are hashed and stored securely in a MySQL database.
   - Users will be assigned unique IDs for managing their scripts.

### 2. **Script Management**
   - After logging in, users can upload, edit, and manage their shell scripts.
   - Each script will have a unique URL that can be used on a Linux machine to execute the script remotely using `wget` or `curl`.
   - Example URL format: `localhost/<userid>/script.sh`.
   - Scripts are stored securely in the backend and executed only when the user invokes the URL with proper permissions.

### 3. **Script Execution via URL**
   - When the user runs the URL `localhost/<userid>/script.sh` on their Linux system using `wget` or `curl | sh`, the shell script will be executed automatically.
   - The server will send the requested script content as a downloadable `.sh` file.
   
### 4. **SMTP Email Feature**
   - SMTP integration will be used for sending out:
     - Registration confirmation emails.
     - Password reset emails.
     - Execution notifications for the shell scripts.
   
### 5. **MySQL Database**
   - A MySQL database will store user data (usernames, emails, passwords) and the associated shell scripts.
   - Each user will have a unique identifier, and their scripts will be mapped to this ID.

### 6. **Dockerized Development**
   - The application will be fully containerized using **Docker** to ensure portability across different environments.
   - Docker will be used for both development and deployment, with separate containers for:
     - Frontend (React)
     - Backend (Node.js)
     - Database (MySQL)
   
   - Docker Compose will be used for easier orchestration of containers.
   
## Tech Stack

- **Frontend:** React.js (for building the user interface)
- **Backend:** Node.js (with Express for handling routes and logic)
- **Database:** MySQL (for storing user credentials and shell scripts)
- **SMTP Email Integration:** Nodemailer (for sending emails)
- **Docker:** For containerizing the app and managing dependencies
- **Shell Script Management:** User-specific shell scripts are stored in the database and served via unique URLs

## Project Structure

### Backend (Node.js)
   - **Authentication Routes:** Handle user login, registration, and password reset functionality.
   - **Script Management Routes:** CRUD operations for users to upload, update, and delete scripts.
   - **SMTP Email Service:** Handles email notifications for various user actions (e.g., registration, password resets, and script execution).
   - **Script Execution Handler:** This will serve user scripts when requested via the URL.

### Frontend (React.js)
   - **Login & Registration Pages:** Forms for users to sign in and register.
   - **Dashboard:** Users can view their stored scripts, upload new ones, and manage existing scripts.
   - **Script Execution URL:** Display the unique URL for each user’s script to run on a Linux machine.
   - **Responsive UI:** Mobile-friendly interface for an optimal user experience.

### MySQL Database
   - **User Table:** Store user credentials, hashed passwords, and email addresses.
   - **Script Table:** Store user scripts and map them to specific user IDs.

## How It Works

1. **User Registration and Login:**
   - A user visits the website and registers with their email and password.
   - The password is hashed and stored in the MySQL database.
   - After successful registration, the user logs in to access their dashboard.

2. **Script Management:**
   - Users can upload new shell scripts through the frontend dashboard.
   - Scripts are saved in the database, mapped to the user’s unique ID.
   - Each user gets a unique URL for executing their script via `wget` or `curl`.

3. **Script Execution:**
   - To execute a script on their Linux machine, the user runs:
     ```bash
     curl -sSL localhost/<userid>/script.sh | bash
     ```
   - The server responds with the requested script, which gets executed on the local system.

4. **SMTP Email Notifications:**
   - Upon registration, users receive a welcome email.
   - When a script is executed, the user is notified via email.
   - Password reset requests are handled via SMTP as well.

## Docker Setup

The entire application is containerized using Docker, and **Docker Compose** is used to orchestrate the services. 

### Steps to Run Locally

1. Clone the repository:
   ```bash
   git clone <repo_url>
   cd <project_directory>
   ```

2. Build the Docker containers:
   ```bash
   docker-compose build
   ```

3. Start the Docker containers:
   ```bash
   docker-compose up
   ```

4. Visit the app on `http://localhost:3000` for the frontend.

5. The backend API will be running at `http://localhost:5000`.

6. The MySQL database will be accessible at `localhost:3306` (if you need to connect for testing).

## Open to Collaborate

This project is open to contributions. If you have any improvements or ideas, feel free to fork the repository and submit a pull request.

### How to Contribute:
1. Fork the repository.
2. Clone your fork to your local machine.
3. Create a new branch for your changes.
4. Make your changes, and ensure to write tests where applicable.
5. Submit a pull request for review.

