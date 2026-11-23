-- ==========================================================
-- Digital Parking Violation and Fine Management System
-- Database Schema Script
-- ==========================================================

DROP DATABASE IF EXISTS parking_violation_db;
CREATE DATABASE parking_violation_db;
USE parking_violation_db;

-- 1. USERS TABLE (Authentication & Roles: ADMIN, OFFICER)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL, -- 'ADMIN' or 'OFFICER'
    full_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. VEHICLES TABLE (Registered vehicle details)
CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_number VARCHAR(20) NOT NULL UNIQUE,
    owner_name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL, -- 'Car', 'Bike', 'Truck', 'Bus', etc.
    contact_number VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. FINE TYPES TABLE (Configurable violation types and standard tariffs)
CREATE TABLE fine_types (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    violation_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    fine_amount DECIMAL(10, 2) NOT NULL
);

-- 4. VIOLATIONS TABLE (Issued violation tickets)
CREATE TABLE violations (
    violation_id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    vehicle_number VARCHAR(20) NOT NULL,
    officer_id INT NOT NULL,
    violation_type VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL,
    violation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fine_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING', -- 'PENDING' or 'PAID'
    notes VARCHAR(255),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (officer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 5. PAYMENTS TABLE (Settlement and receipt records)
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    receipt_number VARCHAR(50) NOT NULL UNIQUE,
    violation_id INT NOT NULL,
    vehicle_number VARCHAR(20) NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL, -- 'CASH', 'CREDIT_CARD', 'UPI', 'NET_BANKING'
    transaction_reference VARCHAR(100),
    FOREIGN KEY (violation_id) REFERENCES violations(violation_id) ON DELETE CASCADE
);

-- ==========================================================
-- SEED DATA FOR TESTING & DEMONSTRATION
-- ==========================================================

-- Seed Users (Passwords for demo: admin123, pass123)
INSERT INTO users (username, password, role, full_name, contact_number) VALUES
('admin', 'admin123', 'ADMIN', 'System Administrator', '9876543210'),
('officer_raj', 'pass123', 'OFFICER', 'Rajesh Kumar (Traffic Inspector)', '9812345678'),
('officer_priya', 'pass123', 'OFFICER', 'Priya Sharma (Sub-Inspector)', '9898765432');

-- Seed Fine Types / Standard Tariffs
INSERT INTO fine_types (violation_name, description, fine_amount) VALUES
('No Parking Zone', 'Vehicle parked in a designated strict no-parking stretch', 500.00),
('Parking on Footpath', 'Vehicle obstructing pedestrian walkway/pavement', 500.00),
('Wrong Side / Angular Parking', 'Improper parking obstructing lane flow', 300.00),
('Blocking Gate / Entrance', 'Vehicle parked blocking residential or commercial gate', 400.00),
('Double Parking', 'Parking parallel to another parked vehicle obstructing traffic', 600.00),
('Unauthorized Reserved Parking', 'Parking in disabled or emergency-reserved bay', 1000.00);

-- Seed Vehicles
INSERT INTO vehicles (vehicle_number, owner_name, vehicle_type, contact_number, address) VALUES
('KA-01-MJ-2024', 'Rahul Sharma', 'Car', '9876500001', '124, 5th Cross, Indiranagar, Bengaluru'),
('MH-12-PQ-4589', 'Ananya Verma', 'Car', '9876500002', 'Flat 302, Green Glen Layout, Pune'),
('DL-03-TC-9012', 'Vikram Patil', 'Bike', '9876500003', 'Sector 14, Rohini, New Delhi'),
('TN-09-BK-3344', 'Karthik Raman', 'Car', '9876500004', '78, Anna Salai, Chennai'),
('KA-05-XY-7788', 'Suresh Reddy', 'Truck', '9876500005', 'Plot 45, Peenya Industrial Area, Bengaluru');

-- Seed Sample Violations (1 Paid, 2 Pending)
INSERT INTO violations (vehicle_id, vehicle_number, officer_id, violation_type, location, violation_date, fine_amount, status, notes) VALUES
(1, 'KA-01-MJ-2024', 2, 'No Parking Zone', 'MG Road Metro Station', '2026-11-20 10:30:00', 500.00, 'PAID', 'Parked near exit gate'),
(2, 'MH-12-PQ-4589', 2, 'Parking on Footpath', 'Brigade Road Junction', '2026-11-21 14:15:00', 500.00, 'PENDING', 'Obstructing footpath passage'),
(3, 'DL-03-TC-9012', 3, 'Double Parking', 'Commercial Street Main', '2026-11-22 17:45:00', 600.00, 'PENDING', 'Parked beside delivery van');

-- Seed Sample Payment for the Paid Violation
INSERT INTO payments (receipt_number, violation_id, vehicle_number, amount_paid, payment_date, payment_method, transaction_reference) VALUES
('REC-20261120-001', 1, 'KA-01-MJ-2024', 500.00, '2026-11-20 11:45:00', 'UPI', 'UPI/TXN987213451');
