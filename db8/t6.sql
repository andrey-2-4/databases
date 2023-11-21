CREATE SCHEMA EMPJOB_PKG;

CREATE OR REPLACE PROCEDURE EMPJOB_PKG.NEW_JOB (
    p_job_id VARCHAR(10),
    p_job_title VARCHAR(35),
    p_min_salary INTEGER
)
LANGUAGE plpgsql
AS $$
    BEGIN
        INSERT INTO public.jobs(job_id, job_title, min_salary, max_salary)
        VALUES (p_job_id, p_job_title, p_min_salary, p_min_salary * 2);
        COMMIT;
    END;
    $$;

CREATE OR REPLACE PROCEDURE EMPJOB_PKG.ADD_JOB_HIST (
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

CREATE OR REPLACE PROCEDURE EMPJOB_PKG.UPD_JOBSAL (
    p_job_id VARCHAR(10),
    p_min_salary INTEGER,
    p_max_salary INTEGER
)
LANGUAGE plpgsql
AS $$
    BEGIN
        -- Задаем новые зараплаты для работы
        UPDATE public.jobs SET min_salary = p_min_salary, max_salary = p_max_salary
        WHERE job_id = p_job_id;

        -- Если не получилось найти или зп мин больше зп макс
        if not found then
            raise notice 'The job with id "%" could not be found', p_job_id;
            ROLLBACK;
        elsif p_min_salary > p_max_salary then
            raise notice 'The max salary is lower than min salary';
            ROLLBACK;
        else
            COMMIT;
        end if;
    END;
    $$;

CREATE OR REPLACE FUNCTION EMPJOB_PKG.GET_YEARS_SERVICE  (
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

CREATE OR REPLACE FUNCTION EMPJOB_PKG.GET_JOB_COUNT (
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

CALL EMPJOB_PKG.NEW_JOB('PR_MAN', 'Public Relations Manager', 6250);
CALL EMPJOB_PKG.ADD_JOB_HIST(110, 'PR_MAN');
