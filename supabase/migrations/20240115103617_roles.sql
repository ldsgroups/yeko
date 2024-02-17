
-- Sequences
CREATE SEQUENCE IF NOT EXISTS roles_id_seq;
-- Table Definition
CREATE TABLE "public"."roles" (
    "id" int4 NOT NULL DEFAULT nextval('roles_id_seq'::regclass),
    "name" varchar NOT NULL UNIQUE,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Column Comments
COMMENT ON COLUMN "public"."roles"."id" IS 'Unique identifier for roles';
COMMENT ON COLUMN "public"."roles"."name" IS 'Role name';
COMMENT ON COLUMN "public"."roles"."created_at" IS 'Timestamp of when the role was created';
COMMENT ON COLUMN "public"."roles"."updated_at" IS 'Timestamp of when the role was last updated';
