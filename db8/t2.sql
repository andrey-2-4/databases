CREATE OR REPLACE PROCEDURE ADD_JOB_HIST (
    p_employee_id INTEGER,
    p_new_job_id VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
    BEGIN
        -- Вставляем текущую работу в историю работ
        INSERT INTO public.job_history
        (SELECT employees.employee_id, hire_date, CURRENT_DATE, employees.job_id
         FROM employees WHERE employee_id = p_employee_id);
        -- Задаем новую работу
        UPDATE public.employees SET job_id = p_new_job_id,
                                    salary = 500 + (SELECT min_salary FROM jobs WHERE jobs.job_id = p_new_job_id)
        WHERE employee_id = p_employee_id;

        -- Если не получилось найти
        if not found then
            raise notice 'The employee with id "%" could not be found', p_employee_id;
            ROLLBACK;
        else
            COMMIT;
        end if;
    END;
    $$;

CALL ADD_JOB_HIST(106, 'SY_ANAL');
