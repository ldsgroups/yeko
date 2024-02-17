CREATE TYPE status_enum AS ENUM ('pending', 'accepted', 'rejected');

CREATE TABLE "public"."schools_teachers" (
    "school_id" uuid NOT NULL,
    "teacher_id" uuid NOT NULL,
    "status" status_enum NOT NULL DEFAULT 'pending',
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("school_id", "teacher_id"),
    CONSTRAINT "schools_teachers_school_id_foreign" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "schools_teachers_teacher_id_foreign" FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "schools_teachers_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "schools_teachers_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "chk_schools_teachers_status" CHECK ("status" IN ('pending', 'accepted', 'rejected'))
);

CREATE INDEX "idx_schools_teachers_school_id_teacher_id" ON "public"."schools_teachers" USING btree("school_id", "teacher_id");

COMMENT ON COLUMN "public"."schools_teachers"."school_id" IS 'School ID for the teacher';
COMMENT ON COLUMN "public"."schools_teachers"."teacher_id" IS 'Teacher ID for the school';
COMMENT ON COLUMN "public"."schools_teachers"."status" IS 'Status of the teacher''s association with the school';
COMMENT ON COLUMN "public"."schools_teachers"."updated_at" IS 'Timestamp of when the relation was last updated';
COMMENT ON COLUMN "public"."schools_teachers"."status" IS 'Status of the teacher''s association with the school';

-- Indexes
CREATE INDEX "idx_schools_teachers_status" ON "public"."schools_teachers"("status");

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_schools_teachers_traceability
    BEFORE UPDATE
    ON "public"."schools_teachers"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
