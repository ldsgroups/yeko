-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."schedules" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "class_id" uuid NOT NULL,
    "subject_id" uuid NOT NULL,
    "teacher_id" uuid NOT NULL,
    "day_of_week" int4 NOT NULL,
    "time_start" time NOT NULL,
    "time_end" time NOT NULL,
    "location" varchar,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column Comments
COMMENT ON COLUMN "public"."schedules"."id" IS 'Unique identifier for schedule';
COMMENT ON COLUMN "public"."schedules"."class_id" IS 'Class ID for the schedule';
COMMENT ON COLUMN "public"."schedules"."subject_id" IS 'Subject ID for the schedule';
COMMENT ON COLUMN "public"."schedules"."teacher_id" IS 'Teacher ID for the schedule';
COMMENT ON COLUMN "public"."schedules"."day_of_week" IS 'Day of the week';
COMMENT ON COLUMN "public"."schedules"."time_start" IS 'Start time of the class';
COMMENT ON COLUMN "public"."schedules"."time_end" IS 'End time of the class';
COMMENT ON COLUMN "public"."schedules"."location" IS 'Location of the class';
COMMENT ON COLUMN "public"."schedules"."created_at" IS 'Timestamp of when the schedule was created';
COMMENT ON COLUMN "public"."schedules"."updated_at" IS 'Timestamp of when the schedule was last updated';
