-- This script only contains the table creation statements and does not fully represent the table in database. It's still missing: indices, triggers. Do not use it as backup.

-- Table Definition
CREATE TABLE "public"."notes" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "subject_id" uuid NOT NULL,
    "student_id" uuid NOT NULL,
    "note" float8,
    "date" timestamptz,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    CONSTRAINT "notes_subject_id_foreign" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "notes_student_id_foreign" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Column Comments
COMMENT ON COLUMN "public"."notes"."id" IS 'Unique identifier for notes';
COMMENT ON COLUMN "public"."notes"."subject_id" IS 'Subject ID for note';
COMMENT ON COLUMN "public"."notes"."student_id" IS 'Student ID for note';
COMMENT ON COLUMN "public"."notes"."note" IS 'The note value';
COMMENT ON COLUMN "public"."notes"."date" IS 'Timestamp of when the note was created';
COMMENT ON COLUMN "public"."notes"."created_at" IS 'Timestamp of when the note was created';
COMMENT ON COLUMN "public"."notes"."updated_at" IS 'Timestamp of when the note was last updated';
