-- Table Definition
CREATE TABLE "public"."schedules" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "class_id" uuid NOT NULL,
    "subject_id" uuid NOT NULL,
    "teacher_id" uuid NOT NULL,
    "day_of_week" int4 NOT NULL,
    "start_time" time NOT NULL,
    "end_time" time NOT NULL,
    "room" varchar,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "start_time_must_be_less_than_end_time" CHECK (start_time < end_time)
);

-- Indexes
CREATE INDEX "idx_schedule_class_id" ON "public"."schedules" USING btree("class_id");
CREATE INDEX "idx_schedule_subject_id" ON "public"."schedules" USING btree("subject_id");
CREATE INDEX "idx_schedule_teacher_id" ON "public"."schedules" USING btree("teacher_id");

-- Column Comments
COMMENT ON COLUMN "public"."schedules"."id" IS 'Unique identifier for schedule';
COMMENT ON COLUMN "public"."schedules"."class_id" IS 'Class ID for the schedule';
COMMENT ON COLUMN "public"."schedules"."subject_id" IS 'Subject ID for the schedule';
COMMENT ON COLUMN "public"."schedules"."teacher_id" IS 'Teacher ID for the schedule';
COMMENT ON COLUMN "public"."schedules"."day_of_week" IS 'Day of the week';
COMMENT ON COLUMN "public"."schedules"."start_time" IS 'Start time of the class';
COMMENT ON COLUMN "public"."schedules"."end_time" IS 'End time of the class';
COMMENT ON COLUMN "public"."schedules"."room" IS 'Teach room';
COMMENT ON COLUMN "public"."schedules"."created_at" IS 'Timestamp of when the schedule was created';
COMMENT ON COLUMN "public"."schedules"."updated_at" IS 'Timestamp of when the schedule was last updated';

-- SEED with class_id = 1, subject_id = 1, teacher_id = 1
