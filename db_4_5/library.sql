CREATE DATABASE library;

\c library;

CREATE TABLE "publisher" (
  "name" VARCHAR(200) PRIMARY KEY,
  "address" VARCHAR(200)
);

CREATE TABLE "book" (
  "ISBN" VARCHAR(200) PRIMARY KEY,
  "year" integer,
  "name" VARCHAR(200),
  "author" VARCHAR(200),
  "pages" integer
);

CREATE TABLE "book_instance" (
  "ISBN" VARCHAR(200),
  "copy_number" integer,
  "position" VARCHAR(200),
  PRIMARY KEY ("ISBN", "copy_number")
);

CREATE TABLE "category" (
  "name" VARCHAR(200) PRIMARY KEY,
  "parent_name" VARCHAR(200)
);

CREATE TABLE "reader" (
  "reader_id" integer PRIMARY KEY,
  "surname" VARCHAR(200),
  "first_name" VARCHAR(200),
  "address" VARCHAR(200),
  "birthday" timestamp
);

CREATE TABLE "borrow" (
  "borrow_id" integer PRIMARY KEY,
  "ISBN" VARCHAR(200),
  "copy_number" integer,
  "reader_id" integer,
  "reutrn_date" timestamp
);

CREATE TABLE "published" (
  "publisher_name" VARCHAR(200),
  "ISBN" VARCHAR(200),
  PRIMARY KEY ("publisher_name", "ISBN")
);

CREATE TABLE "has_category" (
  "ISBN" VARCHAR(200),
  "category_name" VARCHAR(200),
  PRIMARY KEY ("ISBN", "category_name")
);

ALTER TABLE "book_instance" ADD FOREIGN KEY ("ISBN") REFERENCES "book" ("ISBN");

ALTER TABLE "has_category" ADD FOREIGN KEY ("ISBN") REFERENCES "book" ("ISBN");

ALTER TABLE "has_category" ADD FOREIGN KEY ("category_name") REFERENCES "category" ("name");

ALTER TABLE "published" ADD FOREIGN KEY ("publisher_name") REFERENCES "publisher" ("name");

ALTER TABLE "published" ADD FOREIGN KEY ("ISBN") REFERENCES "book" ("ISBN");

ALTER TABLE "borrow" ADD FOREIGN KEY ("ISBN", "copy_number") REFERENCES "book_instance" ("ISBN", "copy_number");

ALTER TABLE "borrow" ADD FOREIGN KEY ("reader_id") REFERENCES "reader" ("reader_id");

-- Publisher table
INSERT INTO "publisher" (name, address) VALUES
('Penguin', '123 Penguin Lane'),
('Random House', '456 Book Lane');

-- Book table
INSERT INTO "book" ("ISBN", year, name, author, pages) VALUES
('111-987-654-321', '1990', 'The Great Gatsby', 'F. Scott Fitzgerald', 200),
('222-123-456-789', '1955', 'To Kill a Mockingbird', 'Harper Lee', 300);

-- Book instance table
INSERT INTO "book_instance" ("ISBN", copy_number, position) VALUES
('111-987-654-321', 1, 'Copy 1'),
('222-123-456-789', 5, 'Copy 5');

-- Category table
INSERT INTO "category" (name, parent_name) VALUES
('Fiction', 'Ultra-category'),
('Non-Fiction', 'Ultra-category');

-- Reader table
INSERT INTO "reader" (reader_id, surname, first_name, address, birthday) VALUES
(1, 'Smith', 'John', '123 Main Street', '2000-01-01'),
(2, 'Johnson', 'Alice', '456 Cherry Lane', '2001-02-02'),
(3, 'Brown', 'Bob', '789 Maple Street', '2002-03-03');

-- Borrow table
INSERT INTO "borrow" (borrow_id, "ISBN", copy_number, reader_id, reutrn_date) VALUES
(1, '111-987-654-321', 1, 1, '2023-01-01'),
(2, '222-123-456-789', 5, 2, '2023-01-02');
