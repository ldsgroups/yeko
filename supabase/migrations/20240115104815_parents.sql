-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."parents" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "full_name" varchar NOT NULL,
    "phone" varchar NOT NULL,
    "email" varchar,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Column Comments
COMMENT ON COLUMN "public"."parents"."id" IS 'Unique identifier for parents';
COMMENT ON COLUMN "public"."parents"."full_name" IS 'Parent fullName';
COMMENT ON COLUMN "public"."parents"."phone" IS 'Parent phone number';
COMMENT ON COLUMN "public"."parents"."email" IS 'Parent email address';
COMMENT ON COLUMN "public"."parents"."created_at" IS 'Timestamp of when the parent was created';
COMMENT ON COLUMN "public"."parents"."updated_at" IS 'Timestamp of when the parent was last updated';
