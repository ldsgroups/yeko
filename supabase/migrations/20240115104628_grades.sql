-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Sequences
CREATE SEQUENCE IF NOT EXISTS grades_id_seq;

-- Table Definition
CREATE TABLE "public"."grades" (
    "id" int4 NOT NULL DEFAULT nextval('grades_id_seq'::regclass),
    "cycle_id" varchar NOT NULL,
    "name" varchar NOT NULL,
    "description" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    CONSTRAINT "grades_cycle_id_foreign" FOREIGN KEY ("cycle_id") REFERENCES "public"."cycles"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Column Comments
COMMENT ON COLUMN "public"."grades"."cycle_id" IS 'Cycle ID for the grade';
COMMENT ON COLUMN "public"."grades"."name" IS 'Grade name';
COMMENT ON COLUMN "public"."grades"."description" IS 'Grade description';
COMMENT ON COLUMN "public"."grades"."created_at" IS 'Timestamp of when the grade was created';
COMMENT ON COLUMN "public"."grades"."updated_at" IS 'Timestamp of when the grade was last updated';
