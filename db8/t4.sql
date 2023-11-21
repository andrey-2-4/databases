CREATE OR REPLACE FUNCTION GET_YEARS_SERVICE  (
    p_employee_id integer
)
    RETURNS INTEGER
LANGUAGE plpgsql
AS $$
    DECLARE years INTEGER;
    BEGIN
        -- Задаем новые зараплаты для работы
        years = EXTRACT(YEAR FROM (SELECT SUM(age) FROM (SELECT AGE(end_date, start_date) as age
        FROM job_history
        WHERE employee_id = p_employee_id
        GROUP BY employee_id, start_date, end_date) as t1));
        return years;
        exception when no_data_found then
            raise notice 'The employee with id "%" could not be found', p_employee_id;
    END;
    $$;

SELECT GET_YEARS_SERVICE(106);
SELECT GET_YEARS_SERVICE(999);
