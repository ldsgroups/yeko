-- Table Definition
CREATE TABLE "public"."schools" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "state_id" int4 DEFAULT 2,
    "cycle_id" varchar NOT NULL,
    "is_technical_education" bool DEFAULT false,
    "name" varchar NOT NULL,
    "code" varchar NOT NULL,
    "address" text,
    "phone" varchar NOT NULL,
    "email" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("id"),
    CONSTRAINT "schools_state_id_foreign" FOREIGN KEY ("state_id") REFERENCES "public"."states"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "schools_cycle_id_foreign" FOREIGN KEY ("cycle_id") REFERENCES "public"."cycles"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "schools_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "schools_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "schools_phone_unique" UNIQUE ("phone"),
    CONSTRAINT "schools_email_unique" UNIQUE ("email"),
    CONSTRAINT "schools_code_unique" UNIQUE ("code")
);

-- Column Comments
COMMENT ON COLUMN "public"."schools"."id" IS 'Unique identifier for schools';
COMMENT ON COLUMN "public"."schools"."state_id" IS 'School state (e.g., "Active", "Inactive", "Pending")';
COMMENT ON COLUMN "public"."schools"."cycle_id" IS 'School cycle (e.g., "Primary", "Secondary")';
COMMENT ON COLUMN "public"."schools"."is_technical_education" IS 'Is this technical secondary education';
COMMENT ON COLUMN "public"."schools"."name" IS 'Name of the school';
COMMENT ON COLUMN "public"."schools"."code" IS 'Code of the school';
COMMENT ON COLUMN "public"."schools"."address" IS 'Address of the school';
COMMENT ON COLUMN "public"."schools"."phone" IS 'School contact phone number';
COMMENT ON COLUMN "public"."schools"."email" IS 'School contact email address';
COMMENT ON COLUMN "public"."schools"."created_at" IS 'Timestamp of when the record was created';
COMMENT ON COLUMN "public"."schools"."updated_at" IS 'Timestamp of when the record was last updated';

-- Indexes
CREATE INDEX "idx_schools_state_id" ON "public"."schools"("state_id");
CREATE INDEX "idx_schools_cycle_id" ON "public"."schools"("cycle_id");
CREATE INDEX "idx_schools_code" ON "public"."schools"("code");

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_schools_traceability
    BEFORE UPDATE
    ON "public"."schools"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
