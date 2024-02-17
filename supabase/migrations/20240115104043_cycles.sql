-- Table Definition
CREATE TABLE "public"."cycles" (
    "id" varchar NOT NULL,
    "name" varchar NOT NULL UNIQUE,
    "description" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id")
);

-- Column Comments
COMMENT ON COLUMN "public"."cycles"."id" IS 'Unique identifier for school cycle';
COMMENT ON COLUMN "public"."cycles"."name" IS 'Cycle name';
COMMENT ON COLUMN "public"."cycles"."description" IS 'Cycle description';
COMMENT ON COLUMN "public"."cycles"."created_at" IS 'Timestamp of when the cycle was created';
COMMENT ON COLUMN "public"."cycles"."updated_at" IS 'Timestamp of when the cycle was last updated';

