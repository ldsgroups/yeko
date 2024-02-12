-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."subjects" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "name" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Column Comments
COMMENT ON COLUMN "public"."subjects"."id" IS 'Unique identifier for subjects';
COMMENT ON COLUMN "public"."subjects"."name" IS 'Subject name';
COMMENT ON COLUMN "public"."subjects"."created_at" IS 'Timestamp of when the subject was created';
COMMENT ON COLUMN "public"."subjects"."updated_at" IS 'Timestamp of when the subject was last updated';
