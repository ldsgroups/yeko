-- Table Definition
CREATE TABLE "public"."participators" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "subject_id" uuid NOT NULL,
    "student_id" uuid NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    -- CONSTRAINT "participators_subject_id_foreign" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "participators_student_id_foreign" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "idx_participator_subject_id" ON "public"."participators" USING btree("subject_id");
CREATE INDEX "idx_participator_student_id" ON "public"."participators" USING btree("student_id");

-- Column Comments
COMMENT ON COLUMN "public"."participators"."id" IS 'Unique identifier for participators';
COMMENT ON COLUMN "public"."participators"."subject_id" IS 'Subject ID for participator';
COMMENT ON COLUMN "public"."participators"."student_id" IS 'Student ID for participator';
COMMENT ON COLUMN "public"."participators"."created_at" IS 'Timestamp of when the parent was created';
COMMENT ON COLUMN "public"."participators"."updated_at" IS 'Timestamp of when the parent was last updated';
