
-- Sequences
CREATE SEQUENCE IF NOT EXISTS grades_id_seq;
-- Table Definition
CREATE TABLE "public"."grades" (
    "id" int4 NOT NULL DEFAULT nextval('grades_id_seq'::regclass),
    "cycle_id" varchar NOT NULL,
    "name" varchar NOT NULL UNIQUE,
    "description" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("id"),
    CONSTRAINT "grades_cycle_id_foreign" FOREIGN KEY ("cycle_id") REFERENCES "public"."cycles" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "grades_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "grades_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE
);

-- Column Comments
COMMENT ON COLUMN "public"."grades"."cycle_id" IS 'Cycle ID for the grade';
COMMENT ON COLUMN "public"."grades"."name" IS 'Grade name';
COMMENT ON COLUMN "public"."grades"."description" IS 'Grade description';
COMMENT ON COLUMN "public"."grades"."created_at" IS 'Timestamp of when the grade was created';
COMMENT ON COLUMN "public"."grades"."updated_at" IS 'Timestamp of when the grade was last updated';

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_grades_traceability
    BEFORE UPDATE
    ON "public"."grades"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();

