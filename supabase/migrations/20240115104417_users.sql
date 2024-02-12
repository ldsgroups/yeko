-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."users" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "role_id" int4 DEFAULT 1,
    "state_id" int4 DEFAULT 1,
    "school_id" uuid,
    "email" varchar NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    CONSTRAINT "users_role_id_foreign" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "users_state_id_foreign" FOREIGN KEY ("state_id") REFERENCES "public"."states"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "users_school_id_foreign" FOREIGN KEY ("school_id") REFERENCES "public"."schools"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "users_email_unique" UNIQUE ("email")
);

-- Column Comments
COMMENT ON COLUMN "public"."users"."id" IS 'Unique identifier for users';
COMMENT ON COLUMN "public"."users"."role_id" IS 'User role (e.g., "Parent", "Teacher", "Admin")';
COMMENT ON COLUMN "public"."users"."state_id" IS 'User state (e.g., "Active", "Inactive", "Pending")';
COMMENT ON COLUMN "public"."users"."school_id" IS 'Related School Id for user';
COMMENT ON COLUMN "public"."users"."email" IS 'User email';
COMMENT ON COLUMN "public"."users"."created_at" IS 'Timestamp of when the user was created';
COMMENT ON COLUMN "public"."users"."updated_at" IS 'Timestamp of when the user was last updated';
