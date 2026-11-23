# Digital Parking Violation and Fine Management System

A desktop Java application developed with **Java Swing**, **JDBC**, and **MySQL**, adhering to the **MVC (Model-View-Controller) + DAO (Data Access Object)** architecture.

---

## 📁 Project Directory Structure
```
java_project/
├── database.sql                                      # MySQL schema and sample seed data
├── pom.xml                                           # Maven dependencies (MySQL Connector & FlatLaf UI)
├── README.md                                         # Project setup and guide
└── src/
    └── main/
        └── java/
            └── com/
                └── parkingsystem/
                    ├── Main.java                    # Application Entry Point
                    ├── model/                       # Data entity POJOs (User, Vehicle, Violation, etc.)
                    │   ├── User.java
                    │   ├── Vehicle.java
                    │   ├── FineType.java
                    │   ├── Violation.java
                    │   └── Payment.java
                    ├── dao/                         # Data Access Objects (CRUD with PreparedStatement)
                    │   ├── UserDAO.java
                    │   ├── VehicleDAO.java
                    │   ├── FineTypeDAO.java
                    │   ├── ViolationDAO.java
                    │   └── PaymentDAO.java
                    ├── view/                        # Java Swing GUI Screens
                    │   ├── LoginFrame.java
                    │   ├── AdminDashboardFrame.java
                    │   ├── VehicleManagementFrame.java
                    │   ├── ViolationEntryFrame.java
                    │   ├── PaymentManagementFrame.java
                    │   └── ReportsFrame.java
                    └── util/                        # DBConnection singleton
                        └── DBConnection.java
```

---

## 🛠️ Step 1: Database Setup in MySQL

1. Open **MySQL Workbench**, **phpMyAdmin**, or the **MySQL Command Line Client**.
2. Run the provided script:
   ```sql
   source C:/Users/valla/Desktop/java_project/database.sql;
   ```
   *(Or simply open `database.sql`, copy all contents, paste into your MySQL query editor, and click **Execute**).*
3. Verify that the database `parking_violation_db` and its 5 tables are created:
   - `users`
   - `vehicles`
   - `fine_types`
   - `violations`
   - `payments`

---

## 🔑 Default Login Credentials (from Seed Data)
| Role | Username | Password | Full Name | Access Level |
| :--- | :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `admin123` | System Administrator | Full Dashboard, Reports & Registry |
| **Officer** | `officer_raj` | `pass123` | Rajesh Kumar (Traffic Inspector) | Ticket Recording Portal |
| **Officer** | `officer_priya` | `pass123` | Priya Sharma (Sub-Inspector) | Ticket Recording Portal |

---

## ⚙️ Configuring Database Credentials
If your MySQL password is not `root`, open:
`src/main/java/com/parkingsystem/util/DBConnection.java`
and update:
```java
public static String USER = "your_mysql_username";
public static String PASSWORD = "your_mysql_password";
```

---

## 🚀 How to Run the Application

### Option A: Using Eclipse / IntelliJ IDEA / NetBeans (Recommended)
1. Open your IDE and choose **Open Project** / **Import Existing Maven Project**.
2. Select the `C:\Users\valla\Desktop\java_project` folder.
3. Locate `src/main/java/com/parkingsystem/Main.java`.
4. Right-click `Main.java` and select **Run As -> Java Application**.

### Option B: Using Maven via Terminal
Open PowerShell or Command Prompt in the project folder and run:
```bash
mvn clean compile exec:java
```
