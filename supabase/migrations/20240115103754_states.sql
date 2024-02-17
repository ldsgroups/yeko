
-- Sequences
CREATE SEQUENCE IF NOT EXISTS states_id_seq;
-- Table Definition
CREATE TABLE "public"."states" (
    "id" int4 NOT NULL DEFAULT nextval('states_id_seq'::regclass),
    "name" varchar NOT NULL UNIQUE,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Column Comments
COMMENT ON COLUMN "public"."states"."id" IS 'Unique identifier for states';
COMMENT ON COLUMN "public"."states"."name" IS 'State name';
COMMENT ON COLUMN "public"."states"."created_at" IS 'Timestamp of when the state was created';
COMMENT ON COLUMN "public"."states"."updated_at" IS 'Timestamp of when the state was last updated';
