-- Table Definition
CREATE TABLE "public"."homeworks" (
    "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
    "class_id" uuid NOT NULL,
    "subject_id" uuid NOT NULL,
    "due_date" timestamptz NOT NULL,
    "it_will_be_a_note" boolean NOT NULL,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("class_id") REFERENCES "public"."classes"("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "idx_homework_class_id" ON "public"."homeworks" USING btree("class_id");
CREATE INDEX "idx_homework_subject_id" ON "public"."homeworks" USING btree("subject_id");
CREATE INDEX "idx_homework_created_at" ON "public"."homeworks" USING btree("created_at");

-- Column Comments
COMMENT ON COLUMN "public"."homeworks"."id" IS 'Unique identifier for homework';
COMMENT ON COLUMN "public"."homeworks"."class_id" IS 'Class ID for the homework';
COMMENT ON COLUMN "public"."homeworks"."subject_id" IS 'Subject ID for the homework';
COMMENT ON COLUMN "public"."homeworks"."due_date" IS 'Due date of the homework';
COMMENT ON COLUMN "public"."homeworks"."it_will_be_a_note" IS 'If the homework will be a note';
COMMENT ON COLUMN "public"."homeworks"."created_at" IS 'Timestamp of when the homework was created';
COMMENT ON COLUMN "public"."homeworks"."updated_at" IS 'Timestamp of when the homework was last updated';
