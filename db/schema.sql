-- Create the eNotes database
CREATE DATABASE IF NOT EXISTS eNotes;
USE eNotes;

-- Create the 'user' table
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Create the 'post' table
CREATE TABLE IF NOT EXISTS post (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    uid INT NOT NULL,
    latitude DOUBLE,
    longitude DOUBLE,
    FOREIGN KEY (uid) REFERENCES user(id) ON DELETE CASCADE
);
