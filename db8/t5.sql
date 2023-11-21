CREATE OR REPLACE FUNCTION GET_JOB_COUNT (
    p_employee_id integer
)
    RETURNS INTEGER
LANGUAGE plpgsql
AS $$
    DECLARE count INTEGER;
    BEGIN
        -- Задаем новые зараплаты для работы
        count = (SELECT COUNT(*) FROM (SELECT DISTINCT job_id FROM job_history WHERE employee_id = p_employee_id
        UNION DISTINCT
        SELECT DISTINCT job_id FROM employees WHERE employee_id = p_employee_id) t1);
        return count;
        exception when no_data_found then
            raise notice 'The employee with id "%" could not be found', p_employee_id;
    END;
    $$;

SELECT GET_JOB_COUNT(176)

