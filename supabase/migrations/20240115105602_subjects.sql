-- Table Definition
CREATE TABLE "public"."subjects" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "name" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "idx_subject_created_at" ON "public"."subjects" USING btree("created_at");

-- Column Comments
COMMENT ON COLUMN "public"."subjects"."id" IS 'Unique identifier for subjects';
COMMENT ON COLUMN "public"."subjects"."name" IS 'Subject name';
COMMENT ON COLUMN "public"."subjects"."created_at" IS 'Timestamp of when the subject was created';
COMMENT ON COLUMN "public"."subjects"."updated_at" IS 'Timestamp of when the subject was last updated';
