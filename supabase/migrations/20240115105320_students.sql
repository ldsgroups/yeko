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
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("parent_id") REFERENCES "public"."parents"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "students_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "students_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
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
CREATE INDEX "idx_student_id_number" ON "public"."students" USING btree("id_number");
CREATE INDEX "idx_student_created_at" ON "public"."students" USING btree("created_at");

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_students_traceability
    BEFORE UPDATE
    ON "public"."students"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
