-- Table Definition
CREATE TABLE "public"."classes" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "school_id" uuid NOT NULL,
    "grade_id" int4 NOT NULL,
    "name" varchar NOT NULL,
    "main_teacher_id" uuid,
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("grade_id") REFERENCES "public"."grades"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("main_teacher_id") REFERENCES "public"."teachers"("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "classes_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "classes_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "unique_class_name" UNIQUE ("school_id", "name")
);

-- Indexes
CREATE INDEX "idx_class_school_id" ON "public"."classes" USING btree("school_id");
CREATE INDEX "idx_class_grade_id" ON "public"."classes" USING btree("grade_id");
CREATE INDEX "idx_class_main_teacher_id" ON "public"."classes" USING btree("main_teacher_id");
CREATE INDEX "idx_class_created_at" ON "public"."classes" USING btree("created_at");

-- Column Comments
COMMENT ON COLUMN "public"."classes"."id" IS 'Unique identifier for classes';
COMMENT ON COLUMN "public"."classes"."school_id" IS 'School ID for the class';
COMMENT ON COLUMN "public"."classes"."grade_id" IS 'Grade ID for the class';
COMMENT ON COLUMN "public"."classes"."name" IS 'Class name';
COMMENT ON COLUMN "public"."classes"."created_at" IS 'Timestamp of when the class was created';
COMMENT ON COLUMN "public"."classes"."updated_at" IS 'Timestamp of when the class was last updated';

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_classes_traceability
    BEFORE UPDATE
    ON "public"."classes"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
