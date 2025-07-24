## 📝 eNotes – Smart Notes Taking Web App

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![Servlet](https://img.shields.io/badge/Servlets-5382a1?style=for-the-badge&logo=apachetomcat&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![HTML](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

### Overview
**eNotes** is a full-stack web application designed to simplify personal note-taking. It offers rich text editing, smart search, geotagging, dark mode support, and a responsive design — all built from the ground up using Java Servlets and JSP on the backend, and HTML/CSS/JS on the frontend.

The goal was to build a clean, functional, and scalable note-taking platform that demonstrates real-world full-stack web development skills using Java EE and MySQL.

### Core Features
->Authentication: Secure login & registration with password encryption and session control.

->Note Management: Create, edit, delete, and search notes with support for multiple text fonts, colors, and formatting styles.

->Smart Features: Optional geolocation tagging and dark/light mode toggle.

->Responsive UI: Mobile-friendly design with reusable, clean UI components.


### Setup & Configuration
#### Database Setup

Create a MySQL database **similar to the structure defined in `db/schema.sql`**.

You’ll find two main tables:
- `user`: Stores account data
- `post`: Stores note content with tags, timestamps, and optional geolocation

> Make sure to update `DBConnect.java` with your own MySQL credentials:

```java
private static final String URL = "jdbc:mysql://localhost:3306/enotes_db";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

#### Run the App
Follow these steps to set up and run the eNotes application locally:

1. Clone the Repository
   ```bash
   git clone https://github.com/ravishaa2005/eNotes-Smart-Notes-Taking-Web-App.git
   cd eNotes-Smart-Notes-Taking-Web-App
   ```

2. Open the Project
   Import the project into Eclipse or IntelliJ IDEA as a Dynamic Web Project or a Maven Project (if using Maven).

3. Configure the Database
   Make sure MySQL is running. Import the schema from db/schema.sql. Update DBConnect.java with your MySQL credentials (already shown above).

4. Deploy the Application
   Configure and deploy the project on Apache Tomcat 9.

5. Access in Browser
   Visit-
   '''bash
   http://localhost:8080/eNotes-Smart-Notes-Taking-Web-App
   ```

  
