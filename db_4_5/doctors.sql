CREATE DATABASE doctors;

\c doctors;

CREATE TABLE "station_personell" (
  "id" integer PRIMARY KEY,
  "Name" VARCHAR(200)
);

CREATE TABLE "caregiver" (
  "id" integer PRIMARY KEY,
  "qualification" VARCHAR(200)
);

CREATE TABLE "doctor" (
  "id" integer PRIMARY KEY,
  "area" VARCHAR(200),
  "rank" VARCHAR(200)
);

CREATE TABLE "station" (
  "id" integer PRIMARY KEY,
  "name" VARCHAR(200)
);

CREATE TABLE "room" (
  "station_id" integer,
  "room_id" integer,
  "beds" integer,
  PRIMARY KEY ("station_id", "room_id")
);

CREATE TABLE "patient" (
  "id" integer PRIMARY KEY,
  "name" VARCHAR(200),
  "disease" VARCHAR(200)
);

CREATE TABLE "works_for" (
  "pers_id" integer UNIQUE,
  "station_id" integer,
  PRIMARY KEY ("pers_id", "station_id")
);

CREATE TABLE "treats" (
  "pers_id" integer,
  "patient_id" integer UNIQUE,
  PRIMARY KEY ("pers_id", "patient_id")
);

CREATE TABLE "admission" (
  "id" integer PRIMARY KEY,
  "patient_id" integer,
  "station_id" integer,
  "room_id" integer,
  "from" timestamp,
  "to" timestamp
);

ALTER TABLE "doctor" ADD FOREIGN KEY ("id") REFERENCES "station_personell" ("id");

ALTER TABLE "station_personell" ADD FOREIGN KEY ("id") REFERENCES "caregiver" ("id");

ALTER TABLE "station_personell" ADD FOREIGN KEY ("id") REFERENCES "works_for" ("pers_id");

ALTER TABLE "works_for" ADD FOREIGN KEY ("station_id") REFERENCES "station" ("id");

ALTER TABLE "room" ADD FOREIGN KEY ("station_id") REFERENCES "station" ("id");

ALTER TABLE "admission" ADD FOREIGN KEY ("station_id", "room_id") REFERENCES "room" ("station_id", "room_id");

ALTER TABLE "treats" ADD FOREIGN KEY ("pers_id") REFERENCES "doctor" ("id");

ALTER TABLE "patient" ADD FOREIGN KEY ("id") REFERENCES "treats" ("patient_id");

INSERT INTO "caregiver" ("id", "qualification") VALUES
(1, 'Nurse'),
(2, 'PT'),
(3, 'Social worker');

INSERT INTO "station" ("id", "name") VALUES
(1, 'ER'),
(2, 'ICU'),
(3, 'Pediatric Ward');

INSERT INTO "works_for" ("pers_id", "station_id") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 1),
(6, 3);

INSERT INTO "station_personell" ("id", "Name") VALUES
(1, 'John'),
(2, 'Sarah'),
(3, 'Jane');

INSERT INTO "doctor" ("id", "area", "rank") VALUES
(1, 'Emergency', 'Chief'),
(2, 'Internal Medicine', 'Intern'),
(3, 'Pediatrics', 'Staff');

INSERT INTO "room" ("station_id", "room_id", "beds") VALUES
(1, 1, 8),
(2, 1, 6),
(2, 2, 2),
(3, 1, 8),
(3, 2, 6);

INSERT INTO "treats" ("pers_id", "patient_id") VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO "patient" ("id", "name", "disease") VALUES
(1, 'John Doe', 'Diabetes'),
(2, 'Jane Smith', 'Heart disease'),
(3, 'Sue Johnson', 'COPD');

INSERT INTO "admission" ("id", "patient_id", "station_id", "room_id", "from", "to") VALUES
(1, 1, 1, 1, '2023-01-01', '2023-02-01');
