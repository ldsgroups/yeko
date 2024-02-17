-- Table Definition
CREATE TABLE "public"."parents" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "full_name" varchar NOT NULL,
    "phone" varchar NOT NULL,
    "email" varchar,
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("id"),
    CONSTRAINT "parents_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "parents_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE
);

-- Indexes
CREATE INDEX "idx_parents_phone" ON "public"."parents"("phone");
CREATE INDEX "idx_parents_email" ON "public"."parents"("email");

-- Column Comments
COMMENT ON COLUMN "public"."parents"."id" IS 'Unique identifier for parents';
COMMENT ON COLUMN "public"."parents"."full_name" IS 'Parent fullName';
COMMENT ON COLUMN "public"."parents"."phone" IS 'Parent phone number';
COMMENT ON COLUMN "public"."parents"."email" IS 'Parent email address';
COMMENT ON COLUMN "public"."parents"."created_at" IS 'Timestamp of when the parent was created';
COMMENT ON COLUMN "public"."parents"."updated_at" IS 'Timestamp of when the parent was last updated';

-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_parents_traceability
    BEFORE UPDATE
    ON "public"."parents"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
