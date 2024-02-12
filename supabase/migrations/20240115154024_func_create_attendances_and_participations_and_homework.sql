-- homeworks can be null
CREATE OR REPLACE FUNCTION public.create_attendance_and_participator_and_homework(
    attendances jsonb,
    participators jsonb,
    homework jsonb DEFAULT null
    ) RETURNS text LANGUAGE plpgsql AS $$
DECLARE 
    err_msg text;

BEGIN
    FOR i IN 0..jsonb_array_length(attendances) - 1 LOOP
        BEGIN
            INSERT INTO public.attendances (student_id, date, status, is_excused, updated_at)
            VALUES (
                (attendances -> i ->> 'student_id')::uuid,
                (attendances -> i ->> 'date')::timestamptz,
                (attendances -> i ->> 'status')::text,
                (attendances -> i ->> 'is_excused')::boolean,
                now()
            );
        EXCEPTION
            WHEN others THEN
                err_msg := 'Error inserting attendance for student_id: ' || (attendances -> i ->> 'student_id') || '|<>| error is: ' || SQLERRM;
                -- You can log or handle the error as per your requirements
                RAISE EXCEPTION '%', err_msg USING HINT = err_msg;
        END;
    END LOOP;

    FOR i IN 0..jsonb_array_length(participators) - 1 LOOP
        BEGIN
            INSERT INTO public.participators (subject_id, student_id, updated_at)
            VALUES (
                (participators -> i ->> 'subject_id')::uuid,
                (participators -> i ->> 'student_id')::uuid,
                now()
            );
        EXCEPTION
            WHEN others THEN
                err_msg := 'Error inserting participator for student_id: ' || (participators -> i ->> 'student_id') || '|<>| error is: ' || SQLERRM;
                -- You can log or handle the error as per your requirements
                RAISE EXCEPTION '%', err_msg USING HINT = err_msg;
        END;
    END LOOP;
    
    IF homework IS NOT NULL THEN
        BEGIN
            INSERT INTO public.homeworks (class_id, subject_id, due_date, it_will_be_a_note, updated_at)
            VALUES (
                (homework ->> 'class_id')::uuid,
                (homework ->> 'subject_id')::uuid,
                (homework ->> 'due_date')::timestamptz,
                (homework ->> 'it_will_be_a_note')::boolean,
                now()
            );
        EXCEPTION
            WHEN others THEN
                err_msg := 'Error inserting homework for class_id: ' || (homework ->> 'class_id') || '|<>| error is: ' || SQLERRM;
                -- You can log or handle the error as per your requirements
                RAISE EXCEPTION '%', err_msg USING HINT = err_msg;
        END;
    END IF;

    RETURN 'OK';

END;
$$ volatile security definer;
