/*
This code snippet is a SQL function named "set_updated_at". It is triggered whenever a row is updated in a table. The function sets the "updated_at" column of the updated row to the current timestamp using the "clock_timestamp()" function. The function then returns the updated row. This function is written in the PL/pgSQL language and has the SECURITY DEFINER attribute.
*/
CREATE FUNCTION
  public.set_traceability()
  RETURNS TRIGGER AS
  $$
  BEGIN
    NEW.updated_by = auth.uid();
    NEW.updated_at = clock_timestamp();
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql SECURITY DEFINER;
