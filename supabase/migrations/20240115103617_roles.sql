-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Sequences
CREATE SEQUENCE IF NOT EXISTS roles_id_seq;

-- Table Definition
CREATE TABLE "public"."roles" (
    "id" int4 NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
    "name" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);
