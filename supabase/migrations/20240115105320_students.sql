-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."students" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "parent_id" uuid NOT NULL,
    "school_id" uuid NOT NULL,
    "class_id" uuid NOT NULL,
    "id_number" varchar NOT NULL,
    "first_name" varchar NOT NULL,
    "last_name" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("parent_id") REFERENCES "public"."parents"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "students_id_number_key" UNIQUE ("id_number")
);

-- Column Comments
COMMENT ON COLUMN "public"."students"."id" IS 'Unique identifier for students';
COMMENT ON COLUMN "public"."students"."parent_id" IS 'Parent ID for the student';
COMMENT ON COLUMN "public"."students"."school_id" IS 'School ID for the student';
COMMENT ON COLUMN "public"."students"."class_id" IS 'Class ID for the student';
COMMENT ON COLUMN "public"."students"."id_number" IS 'Student ID number';
COMMENT ON COLUMN "public"."students"."first_name" IS 'Student first name';
COMMENT ON COLUMN "public"."students"."last_name" IS 'Student last name';
COMMENT ON COLUMN "public"."students"."created_at" IS 'Timestamp of when the student was created';
COMMENT ON COLUMN "public"."students"."updated_at" IS 'Timestamp of when the student was last updated';

-- Indexes
CREATE INDEX "idx_student_parent_id" ON "public"."students" USING btree("parent_id");
CREATE INDEX "idx_student_school_id" ON "public"."students" USING btree("school_id");
CREATE INDEX "idx_student_class_id" ON "public"."students" USING btree("class_id");
