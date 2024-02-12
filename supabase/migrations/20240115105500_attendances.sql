-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."attendances" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "student_id" uuid NOT NULL,
    "date" timestamptz NOT NULL,
    "status" text NOT NULL DEFAULT 'present'::text,
    "is_excused" boolean NOT NULL DEFAULT false,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column Comments
COMMENT ON COLUMN "public"."attendances"."id" IS 'Unique identifier for students';
COMMENT ON COLUMN "public"."attendances"."student_id" IS 'Student ID for attendance';
COMMENT ON COLUMN "public"."attendances"."date" IS 'Date of the attendance record';
COMMENT ON COLUMN "public"."attendances"."status" IS 'Attendance status (e.g., "present", "absent", "late")';
COMMENT ON COLUMN "public"."attendances"."is_excused" IS 'Whether the attendance is excused';
COMMENT ON COLUMN "public"."attendances"."created_at" IS 'Timestamp of when the attendance was created';
COMMENT ON COLUMN "public"."attendances"."updated_at" IS 'Timestamp of when the attendance was last updated';
