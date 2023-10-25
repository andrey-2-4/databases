-- Создаем базу данных
CREATE DATABASE testdb;

-- Используем созданную базу данных
\c testdb;

-- Создаем таблицу users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT
);

-- Добавляем записи в таблицу
INSERT INTO users (name, email, age) VALUES ('Alice', 'alice@email.com', 28);
INSERT INTO users (name, email, age) VALUES ('Bob', 'bob@email.com', 30);
INSERT INTO users (name, email, age) VALUES ('Charlie', 'charlie@email.com', 25);

SELECT * FROM users;