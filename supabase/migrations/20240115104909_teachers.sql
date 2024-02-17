-- Table Definition
CREATE TABLE "public"."teachers" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "full_name" varchar NOT NULL,
    "phone" varchar NOT NULL,
    "email" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("id"),
    CONSTRAINT "teachers_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "teachers_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE
);

-- Indexes
CREATE INDEX "idx_teachers_phone" ON "public"."teachers"("phone");
CREATE INDEX "idx_teachers_email" ON "public"."teachers"("email");
CREATE INDEX "idx_teachers_created_by" ON "public"."teachers"("created_by");

-- Column Comments
COMMENT ON COLUMN "public"."teachers"."id" IS 'Unique identifier for teachers';
COMMENT ON COLUMN "public"."teachers"."full_name" IS 'Teacher fullName';
COMMENT ON COLUMN "public"."teachers"."phone" IS 'Teacher phone number';
COMMENT ON COLUMN "public"."teachers"."email" IS 'Teacher email address';
COMMENT ON COLUMN "public"."teachers"."created_at" IS 'Timestamp of when the teacher was created';
COMMENT ON COLUMN "public"."teachers"."updated_at" IS 'Timestamp of when the teacher was last updated';

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_teachers_traceability
    BEFORE UPDATE
    ON "public"."teachers"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
