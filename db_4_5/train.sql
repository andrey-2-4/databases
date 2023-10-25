CREATE DATABASE train;

\c train;

CREATE TABLE "station" (
  "name" VARCHAR(200) PRIMARY KEY,
  "tracks" integer
);

CREATE TABLE "city" (
  "name" VARCHAR(200),
  "region" VARCHAR(200),
  PRIMARY KEY ("name", "region")
);

CREATE TABLE "train" (
  "id" integer PRIMARY KEY,
  "tracks" integer
);

CREATE TABLE "connected" (
  "train_id" integer UNIQUE,
  "departure_station_name" VARCHAR(200) UNIQUE,
  "arrival_station_name" VARCHAR(200) UNIQUE,
  PRIMARY KEY ("train_id", "departure_station_name", "arrival_station_name")
);

CREATE TABLE "start" (
  "train_id" integer,
  "station_name" VARCHAR(200),
  PRIMARY KEY ("train_id", "station_name")
);

CREATE TABLE "end" (
  "train_id" integer,
  "station_name" VARCHAR(200),
  PRIMARY KEY ("train_id", "station_name")
);

CREATE TABLE "lie_in" (
  "station_name" VARCHAR(200) UNIQUE,
  "city_name" VARCHAR(200),
  "region" VARCHAR(200),
  PRIMARY KEY ("station_name", "city_name", "region")
);

ALTER TABLE "connected" ADD FOREIGN KEY ("train_id") REFERENCES "train" ("id");

ALTER TABLE "connected" ADD FOREIGN KEY ("departure_station_name") REFERENCES "station" ("name");

ALTER TABLE "connected" ADD FOREIGN KEY ("arrival_station_name") REFERENCES "station" ("name");

ALTER TABLE "lie_in" ADD FOREIGN KEY ("station_name") REFERENCES "station" ("name");

ALTER TABLE "lie_in" ADD FOREIGN KEY ("city_name", "region") REFERENCES "city" ("name", "region");

ALTER TABLE "start" ADD FOREIGN KEY ("station_name") REFERENCES "station" ("name");

ALTER TABLE "end" ADD FOREIGN KEY ("station_name") REFERENCES "station" ("name");

ALTER TABLE "start" ADD FOREIGN KEY ("train_id") REFERENCES "train" ("id");

ALTER TABLE "end" ADD FOREIGN KEY ("train_id") REFERENCES "train" ("id");

INSERT INTO "connected" (train_id, departure_station_name, arrival_station_name) VALUES
(1, 'Paris', 'New York'),
(4, 'Berlin', 'London');

INSERT INTO "station" (name, tracks) VALUES
('Paris', 10),
('London', 7),
('Berlin', 5),
('New York', 20);

INSERT INTO "city" (name, region) VALUES
('Paris', 'France'),
('London', 'UK'),
('Berlin', 'Germany'),
('New York', 'USA');

INSERT INTO "train" (id, tracks) VALUES
(1, 10),
(2, 7),
(3, 5),
(4, 20);

INSERT INTO "start" (train_id, station_name) VALUES
(1, 'Paris'),
(1, 'New York'),
(4, 'Paris'),
(4, 'London');

INSERT INTO "end" (train_id, station_name) VALUES
(1, 'Paris'),
(1, 'New York'),
(4, 'Paris'),
(4, 'London');

INSERT INTO "lie_in" (station_name, city_name, region) VALUES
('Paris', 'Paris', 'France'),
('New York', 'New York', 'USA'),
('London', 'London', 'UK'),
('Berlin', 'Berlin', 'Germany');




