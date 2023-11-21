CREATE OR REPLACE PROCEDURE UPD_JOBSAL (
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

SELECT * FROM jobs WHERE job_id = 'SY_ANAL';
CALL UPD_JOBSAL('SY_ANAL', 7000, 140);
SELECT * FROM jobs WHERE job_id = 'SY_ANAL';
CALL UPD_JOBSAL('SY_ANAL', 7000, 14000);
SELECT * FROM jobs WHERE job_id = 'SY_ANAL';
