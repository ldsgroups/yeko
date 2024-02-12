-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."classes" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "school_id" uuid NOT NULL,
    "grade_id" int4 NOT NULL,
    "name" varchar NOT NULL,
    "main_teacher_id" uuid,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("grade_id") REFERENCES "public"."grades"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("main_teacher_id") REFERENCES "public"."teachers"("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "unique_class_name" UNIQUE ("school_id", "name")
);

-- Column Comments
COMMENT ON COLUMN "public"."classes"."id" IS 'Unique identifier for classes';
COMMENT ON COLUMN "public"."classes"."school_id" IS 'School ID for the class';
COMMENT ON COLUMN "public"."classes"."grade_id" IS 'Grade ID for the class';
COMMENT ON COLUMN "public"."classes"."name" IS 'Class name';
COMMENT ON COLUMN "public"."classes"."created_at" IS 'Timestamp of when the class was created';
COMMENT ON COLUMN "public"."classes"."updated_at" IS 'Timestamp of when the class was last updated';


-- Indexes
CREATE INDEX "idx_class_school_id" ON "public"."classes" USING btree("school_id");
CREATE INDEX "idx_class_grade_id" ON "public"."classes" USING btree("grade_id");
