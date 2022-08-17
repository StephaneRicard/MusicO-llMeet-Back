-- Deploy meeto_ll_musical:init to pg

BEGIN;

CREATE TABLE "momer_type"(
    "id" INT UNIQUE PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "candidate_status"(
    "id" INT UNIQUE PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "user" (
    "id" INT UNIQUE PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "picture_url" TEXT,
    "city" VARCHAR(50) NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "phone" INT,
    "address" TEXT,
    "county" VARCHAR(50) NOT NULL,
    "role" VARCHAR(20) NOT NULL,
    "description" VARCHAR(500),
    "musicians_number" INT,
    "group_leader" VARCHAR(100),
    "external_url" TEXT,
    "momer_to_contact" VARCHAR(100),
    "momer_type_id" INT REFERENCES "momer_type" ("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "event"(
    "id" INT UNIQUE PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "picture_url" TEXT,
    "owner_id" INT NOT NULL REFERENCES "user" ("id"),
    "address" TEXT,
    "county" VARCHAR(50) NOT NULL,
    "is_published" BOOLEAN NOT NULL,
    "is_archived" BOOLEAN NOT NULL,
    "event_date" TIMESTAMPTZ NOT NULL,
    "external_link" TEXT,
    "event_type" INT NOT NULL,
    "type_of_music_needed" VARCHAR(100) NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "musical_type"(
    "id" INT UNIQUE PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "candidate_per_event"(
    "id" INT UNIQUE PRIMARY KEY,
    "event_id" INT NOT NULL REFERENCES "event" ("id"),
    "user_id" INT NOT NULL REFERENCES "user" ("id"),
    "candidate_status_id" INT NOT NULL REFERENCES "candidate_status" ("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "musical_type_per_user"(
    "id" INT UNIQUE PRIMARY KEY,
    "musical_type_id" INT NOT NULL REFERENCES "musical_type" ("id"),
    "user_id" INT NOT NULL REFERENCES "user" ("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

COMMIT;