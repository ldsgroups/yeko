-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."schools_teachers" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "school_id" uuid NOT NULL,
    "teacher_id" uuid NOT NULL,
    "is_active" bool DEFAULT true,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    CONSTRAINT "schools_teachers_school_id_foreign" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "schools_teachers_teacher_id_foreign" FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Column Comments
COMMENT ON COLUMN "public"."schools_teachers"."id" IS 'Unique identifier for the relation';
COMMENT ON COLUMN "public"."schools_teachers"."school_id" IS 'School ID for the teacher';
COMMENT ON COLUMN "public"."schools_teachers"."teacher_id" IS 'Teacher ID for the school';
COMMENT ON COLUMN "public"."schools_teachers"."created_at" IS 'Timestamp of when the relation was created';
COMMENT ON COLUMN "public"."schools_teachers"."updated_at" IS 'Timestamp of when the relation was last updated';
