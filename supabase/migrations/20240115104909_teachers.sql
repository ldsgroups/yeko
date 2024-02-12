-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."teachers" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "full_name" varchar NOT NULL,
    "phone" varchar NOT NULL,
    "email" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Column Comments
COMMENT ON COLUMN "public"."teachers"."id" IS 'Unique identifier for teachers';
COMMENT ON COLUMN "public"."teachers"."full_name" IS 'Teacher fullName';
COMMENT ON COLUMN "public"."teachers"."phone" IS 'Teacher phone number';
COMMENT ON COLUMN "public"."teachers"."email" IS 'Teacher email address';
COMMENT ON COLUMN "public"."teachers"."created_at" IS 'Timestamp of when the teacher was created';
COMMENT ON COLUMN "public"."teachers"."updated_at" IS 'Timestamp of when the teacher was last updated';
