-- function to create user after insert into auth.users
CREATE FUNCTION
  public.store_user_info_on_sign_up()
  RETURNS TRIGGER AS
  $$
  BEGIN
    INSERT INTO public.users (id, email, updated_at)
    VALUES (NEW.id, NEW.email, now());
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql SECURITY DEFINER;

-- trigger to create user after insert into auth.users
CREATE TRIGGER create_user_on_signup
    AFTER INSERT
    ON auth.users
    FOR EACH ROW
EXECUTE PROCEDURE public.store_user_info_on_sign_up();
