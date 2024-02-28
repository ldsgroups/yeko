-- CREATE TYPE status_enum AS ENUM ('pending', 'accepted', 'rejected');

CREATE TABLE "public"."transactions" (
    "from_school_id" uuid NOT NULL,
    "to_school_id" uuid NOT NULL,
    "student_id" uuid NOT NULL,
    "status" status_enum NOT NULL DEFAULT 'pending',
    "created_at" timestamptz default now(),
    "created_by" uuid default auth.uid(),
    "updated_at" timestamptz default now(),
    "updated_by" uuid default auth.uid(),
    PRIMARY KEY ("from_school_id", "to_school_id", "student_id"),
    CONSTRAINT "transactions_from_school_id_foreign" FOREIGN KEY ("from_school_id") REFERENCES "public"."schools"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "transactions_to_school_id_foreign" FOREIGN KEY ("to_school_id") REFERENCES "public"."schools"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "transactions_student_id_foreign" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "transactions_created_by_foreign" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    CONSTRAINT "transactions_updated_by_foreign" FOREIGN KEY ("updated_by") REFERENCES "auth"."users"("id") ON DELETE CASCADE,
    -- TODO: Make sure "public"."students"."school_id" is equal to "public"."transactions"."from_school_id"
    -- TODO: Make sure from_school_id and to_school_id are not the same
    CONSTRAINT "chk_transactions_status" CHECK ("status" IN ('pending', 'accepted', 'rejected'))
);

-- Indexes
CREATE INDEX "idx_transactions_from_school_id_to_school_id_student_id" ON "public"."transactions" USING btree("from_school_id", "to_school_id", "student_id");

CREATE TYPE status_enum AS ENUM ('pending', 'accepted', 'rejected');
-- Function
-- TODO: fix ==> IF status_changed AND NEW.status = 'accepted' THEN <==
CREATE OR REPLACE FUNCTION
  public.update_student_school()
  RETURNS TRIGGER AS
  $$
  DECLARE
    status_changed boolean;
  BEGIN
    -- check if old and new status are same then sock it to status_changed
    status_changed = OLD.status = NEW.status;

    IF status_changed AND NEW.status = 'accepted' THEN
      UPDATE "public"."students" SET school_id = NEW.to_school_id WHERE id = NEW.student_id;
    END IF;

    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql SECURITY DEFINER;


-- Trigger for changing student school columns
CREATE TRIGGER set_new_school_to_student
    AFTER UPDATE
    ON "public"."transactions"
    FOR EACH ROW
EXECUTE PROCEDURE public.update_student_school();


-- Trigger for setting the updated_at and updated_by columns
CREATE TRIGGER set_transactions_traceability
    BEFORE UPDATE
    ON "public"."transactions"
    FOR EACH ROW
EXECUTE PROCEDURE public.set_traceability();
