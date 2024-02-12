-- Function: public.get_statistics

-- Description:
-- This function retrieves statistics related to schools, students, new accounts, and reconnection rates based on the provided date range or default parameters.

-- Parameters:
-- start_date (TIMESTAMP): The start date for the date range. Default is NULL.
-- end_date (TIMESTAMP): The end date for the date range. Default is NULL.

-- Return must contain also last 5 schools joined with columns (name, email and phone) where state_id is not equal to 1

-- Returns:
-- TABLE(school_count BIGINT, student_count BIGINT, new_account_count BIGINT, reconnection_rate DECIMAL): A table containing statistics for schools, students, new accounts, and reconnection rates.

-- Error Handling:
-- - Raises an exception if start_date is greater than end_date.

CREATE OR REPLACE FUNCTION public.get_statistics (
  start_date TIMESTAMP DEFAULT NULL,
  end_date TIMESTAMP DEFAULT NULL
) 
RETURNS TABLE (
  school_count BIGINT,
  student_count BIGINT,
  new_account_count BIGINT,
  reconnection_rate DECIMAL
) 
LANGUAGE plpgsql 
AS $$
BEGIN
  -- Check if start_date is greater than end_date
  IF start_date IS NOT NULL AND end_date IS NOT NULL AND start_date > end_date THEN
    RAISE EXCEPTION 'Start date cannot be greater than end date';
  END IF;

  -- Retrieve statistics
  RETURN QUERY
    SELECT
      s_count AS school_count,
      st_count AS student_count,
      new_accounts.count AS new_account_count,
      (reconnected_sessions * 1.0 / total_sessions) AS reconnection_rate
    FROM
      (SELECT count(*) AS s_count FROM public.schools WHERE created_at >= COALESCE(start_date, DATE_TRUNC('year', CURRENT_DATE)) AND updated_at <= COALESCE(end_date, DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' - INTERVAL '1 day')) AS school_len,
      (SELECT count(*) AS st_count FROM public.students WHERE created_at >= COALESCE(start_date, DATE_TRUNC('year', CURRENT_DATE)) AND updated_at <= COALESCE(end_date, DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' - INTERVAL '1 day')) AS student_len,
      (
        SELECT count(*) AS count
        FROM auth.users
        WHERE created_at >= NOW() - INTERVAL '30 days'
      ) AS new_accounts,
      (
        SELECT
          count(*) AS total_sessions,
          count(*) FILTER (WHERE refreshed_at IS NOT NULL) AS reconnected_sessions
        FROM auth.sessions
      ) AS session_stats;
END;
$$ VOLATILE SECURITY DEFINER;


-- -- Test Cases:

-- -- Test Case 1: Call the function with default parameters
-- SELECT * FROM public.get_statistics();

-- -- Test Case 2: Call the function with custom start_date and end_date parameters
-- SELECT * FROM public.get_statistics('2024-01-01'::TIMESTAMP, '2024-12-31'::TIMESTAMP);

-- -- Test Case 3: Call the function with only the `start_date` parameter
-- SELECT * FROM public.get_statistics('2024-01-01'::TIMESTAMP);

-- -- Test Case 4: Call the function with only the `end_date` parameter
-- SELECT * FROM public.get_statistics(NULL, '2024-12-31'::TIMESTAMP);

-- -- Test Case 5: Call the function with invalid date ranges
-- SELECT * FROM public.get_statistics('2024-12-31'::TIMESTAMP, '2024-01-01'::TIMESTAMP);

-- -- Test Case 6: Call the function with a specific range of dates to test the new account count
-- SELECT * FROM public.get_statistics('2024-01-01'::TIMESTAMP, '2024-12-31'::TIMESTAMP);

-- Function: get_monthly_attendance_summary

-- Description:
-- This function retrieves monthly attendance summary data based on the specified parameters.

-- Parameters:
-- start_date (TIMESTAMP): The start date for the summary period. Default is the beginning of the current year.
-- end_date (TIMESTAMP): The end date for the summary period. Default is the end of the current year.
-- grouping_level (VARCHAR): The level of grouping for the summary data. Options are 'month', 'quarter', or 'year'. Default is 'month'.
-- sort_col (VARCHAR): The column used for sorting the summary data. Options are 'month' or 'attendance'. Default is 'month'.

-- Returns:
-- TABLE(month_label TEXT, attendance_count BIGINT): A table containing the month labels and corresponding attendance counts.

-- Error Handling:
-- - Raises an exception if the start_date is greater than the end_date.
-- - Raises an exception if the grouping_level or sort_col parameters are invalid.

CREATE OR REPLACE FUNCTION public.get_monthly_attendance_summary(
  start_date TIMESTAMP DEFAULT DATE_TRUNC('year', CURRENT_DATE),
  end_date TIMESTAMP DEFAULT DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' - INTERVAL '1 day',
  grouping_level VARCHAR = 'month',
  sort_col VARCHAR = 'month'
)
RETURNS TABLE(month_label TEXT, attendance_count BIGINT) AS $$
BEGIN
  -- Check if start_date is greater than end_date
  IF start_date > end_date THEN
    RAISE EXCEPTION 'Start date cannot be greater than end date';
  END IF;

  -- Check if grouping_level is valid
  IF grouping_level NOT IN ('month', 'quarter', 'year') THEN
    RAISE EXCEPTION 'Invalid grouping level: %', grouping_level;
  END IF;

  -- Check if sort_col is valid
  IF sort_col NOT IN ('month', 'attendance') THEN
    RAISE EXCEPTION 'Invalid sort column: %', sort_col;
  END IF;

  -- Main query
  RETURN QUERY
  SELECT get_group_label(date, grouping_level) AS month_label,
         COUNT(*) AS attendance_count
  FROM attendances
  WHERE date >= COALESCE(start_date, DATE_TRUNC('year', CURRENT_DATE))
        AND date < COALESCE(end_date, DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' - INTERVAL '1 day')
  GROUP BY get_group_label(date, grouping_level)
  ORDER BY CASE WHEN sort_col = 'month' THEN month_label END,
           CASE WHEN sort_col = 'attendance' THEN attendance_count::TEXT END;
           
EXCEPTION
  -- Catch and handle exceptions
  WHEN others THEN
    -- Log the error
    RAISE NOTICE 'An error occurred: %', SQLERRM;
    -- Optionally, you can re-raise the exception
    -- RAISE EXCEPTION SQLERRM;
END;
$$ LANGUAGE plpgsql;

-- Function: get_group_label

-- Description:
-- This function generates labels for different grouping levels (month, quarter, or year) based on the provided date.

-- Parameters:
-- group_date (TIMESTAMP WITH TIME ZONE): The date for which the label is generated.
-- grouping_level (VARCHAR): The level of grouping for the label. Options are 'month', 'quarter', or 'year'.

-- Returns:
-- TEXT: The generated label for the specified grouping level.

CREATE OR REPLACE FUNCTION public.get_group_label(
  group_date TIMESTAMP WITH TIME ZONE,
  grouping_level VARCHAR
)
RETURNS TEXT AS $$
BEGIN
  CASE WHEN grouping_level = 'quarter' THEN
    -- Generate label for quarter
    RETURN TO_CHAR(group_date, 'YYYY-Q') || EXTRACT(QUARTER FROM group_date)::TEXT;
  WHEN grouping_level = 'year' THEN
    -- Generate label for year
    RETURN TO_CHAR(group_date, 'YYYY');
  ELSE
    -- Generate label for month (default)
    RETURN TO_CHAR(group_date, 'YYYY-MM');
  END CASE;
END;
$$ LANGUAGE plpgsql;

-- -- Test Cases:

-- -- Call the function with default parameters
-- SELECT * FROM get_monthly_attendance_summary();

-- -- Call the function with custom parameters
-- SELECT * FROM get_monthly_attendance_summary('2024-01-01'::TIMESTAMP, '2024-12-31'::TIMESTAMP, 'quarter', 'attendance');

-- -- Call the function with different grouping levels and sorting columns
-- SELECT * FROM get_monthly_attendance_summary('2024-01-01'::TIMESTAMP, '2024-12-31'::TIMESTAMP, 'year', 'month');
-- SELECT * FROM get_monthly_attendance_summary('2024-01-01'::TIMESTAMP, '2024-12-31'::TIMESTAMP, 'month', 'attendance');


-- Function: public.get_last_five_inactive_schools()

-- Description:
-- This function retrieves information about the last five inactive schools based on the 'state_id' column from the 'public.schools' table. An inactive school is defined as a school where 'state_id' is not equal to 1.

-- Returns:
-- TABLE(
--   name TEXT: The name of the school.
--   email TEXT: The email address of the school.
--   phone TEXT: The phone number of the school.
-- ): A table containing the names, email addresses, and phone numbers of the last five inactive schools, ordered by their creation date in descending order.

-- Error Handling:
-- - No error handling is explicitly implemented in this function.

CREATE OR REPLACE FUNCTION public.get_last_five_inactive_schools()
RETURNS TABLE(name TEXT, email TEXT, phone TEXT) AS $$
BEGIN
  -- Retrieve information about the last five inactive schools
  RETURN QUERY 
    SELECT s.name::TEXT, s.email::TEXT, s.phone::TEXT
    FROM public.schools s
    WHERE s.state_id != 1
    ORDER BY s.created_at DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

-- -- TEST CASE
-- -- Retrieve information about the last five inactive schools
-- SELECT * FROM get_last_five_inactive_schools();
