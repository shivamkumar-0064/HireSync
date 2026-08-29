#Overall Hiring Funnel let's see how candidates move through the recruitment process.
USE hiresync;

SELECT 
    stage,
    COUNT(DISTINCT application_id) AS applications
FROM application_stage_history
GROUP BY stage
ORDER BY 
    CASE stage
        WHEN 'Applied' THEN 1
        WHEN 'Screened' THEN 2
        WHEN 'Interviewed' THEN 3
        WHEN 'Offered' THEN 4
        WHEN 'Hired' THEN 5
        WHEN 'Dropped' THEN 6
    END;
       
#calculate the exact conversion rates
SELECT
    ROUND(2571 * 100.0 / 3000, 2) AS Applied_to_Screened,
    ROUND(1776 * 100.0 / 2571, 2) AS Screened_to_Interviewed,
    ROUND(973 * 100.0 / 1776, 2) AS Interviewed_to_Offered,
    ROUND(727 * 100.0 / 973, 2) AS Offered_to_Hired,
    ROUND(727 * 100.0 / 3000, 2) AS Overall_Application_to_Hire;
    
    
#Average Time to Hire Now I'll calculate how many days it takes, on average, from application to hiring.
SELECT
    ROUND(
        AVG(
            DATEDIFF(hire_date, applied_date)
        ),
        2
    ) AS average_time_to_hire_days
FROM (
    SELECT
        a.application_id,
        MIN(a.applied_date) AS applied_date,
        MIN(
            CASE
                WHEN ash.stage = 'Hired'
                THEN ash.stage_date
            END
        ) AS hire_date
    FROM applications a
    JOIN application_stage_history ash
        ON a.application_id = ash.application_id
    GROUP BY a.application_id
) AS hiring_data
WHERE hire_date IS NOT NULL;

#Stage-wise Drop-off Analysis how many applications were lost at each recruitment stage.
WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN stage = 'Applied' THEN application_id END) AS applied,
        COUNT(DISTINCT CASE WHEN stage = 'Screened' THEN application_id END) AS screened,
        COUNT(DISTINCT CASE WHEN stage = 'Interviewed' THEN application_id END) AS interviewed,
        COUNT(DISTINCT CASE WHEN stage = 'Offered' THEN application_id END) AS offered,
        COUNT(DISTINCT CASE WHEN stage = 'Hired' THEN application_id END) AS hired
    FROM application_stage_history
)

SELECT
    applied - screened AS applied_to_screened_drop,
    screened - interviewed AS screened_to_interviewed_drop,
    interviewed - offered AS interviewed_to_offered_drop,
    offered - hired AS offered_to_hired_drop
FROM funnel;


#Employer Hiring Performance find which companies/employers are hiring the most candidates.
SELECT
    e.employer_id,
    e.company_name,
    COUNT(DISTINCT CASE
        WHEN ash.stage = 'Hired'
        THEN ash.application_id
    END) AS total_hires
FROM employers e
LEFT JOIN jobs j
    ON e.employer_id = j.employer_id
LEFT JOIN applications a
    ON j.job_id = a.job_id
LEFT JOIN application_stage_history ash
    ON a.application_id = ash.application_id
GROUP BY
    e.employer_id,
    e.company_name
ORDER BY total_hires DESC;

#Employer-wise Hiring Performance
SELECT
    e.employer_id,
    e.company_name,
    COUNT(DISTINCT a.application_id) AS total_applications,
    COUNT(DISTINCT CASE
        WHEN ash.stage = 'Hired'
        THEN ash.application_id
    END) AS total_hires,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN ash.stage = 'Hired'
            THEN ash.application_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT a.application_id), 0),
        2
    ) AS hiring_conversion_rate
FROM employers e
LEFT JOIN jobs j
    ON e.employer_id = j.employer_id
LEFT JOIN applications a
    ON j.job_id = a.job_id
LEFT JOIN application_stage_history ash
    ON a.application_id = ash.application_id
GROUP BY
    e.employer_id,
    e.company_name
ORDER BY hiring_conversion_rate DESC;

#Job-wise Performance
SELECT
    j.job_id,
    j.job_title,
    COUNT(DISTINCT a.application_id) AS total_applications,
    COUNT(DISTINCT CASE
        WHEN ash.stage = 'Hired'
        THEN ash.application_id
    END) AS total_hires,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN ash.stage = 'Hired'
            THEN ash.application_id
        END) * 100.0
        / NULLIF(COUNT(DISTINCT a.application_id), 0),
        2
    ) AS hiring_conversion_rate
FROM jobs j
LEFT JOIN applications a
    ON j.job_id = a.job_id
LEFT JOIN application_stage_history ash
    ON a.application_id = ash.application_id
GROUP BY
    j.job_id,
    j.job_title
ORDER BY total_applications DESC;

#Stage-to-Stage Duration
WITH stage_dates AS (
    SELECT
        application_id,
        stage,
        stage_date,
        LEAD(stage) OVER (
            PARTITION BY application_id
            ORDER BY stage_date, history_id
        ) AS next_stage,
        LEAD(stage_date) OVER (
            PARTITION BY application_id
            ORDER BY stage_date, history_id
        ) AS next_stage_date
    FROM application_stage_history
)

SELECT
    stage AS from_stage,
    next_stage AS to_stage,
    COUNT(*) AS applications,
    ROUND(
        AVG(DATEDIFF(next_stage_date, stage_date)),
        2
    ) AS average_days
FROM stage_dates
WHERE next_stage IS NOT NULL
GROUP BY stage, next_stage
ORDER BY average_days DESC;

#Overall Time to Hire
WITH hiring_dates AS (
    SELECT
        a.application_id,
        a.applied_date,
        MIN(
            CASE
                WHEN ash.stage = 'Hired'
                THEN ash.stage_date
            END
        ) AS hire_date
    FROM applications a
    JOIN application_stage_history ash
        ON a.application_id = ash.application_id
    GROUP BY
        a.application_id,
        a.applied_date
)

SELECT
    COUNT(*) AS total_hired_applications,
    ROUND(
        AVG(DATEDIFF(hire_date, applied_date)),
        2
    ) AS average_time_to_hire_days,
    MIN(DATEDIFF(hire_date, applied_date)) AS minimum_days,
    MAX(DATEDIFF(hire_date, applied_date)) AS maximum_days
FROM hiring_dates
WHERE hire_date IS NOT NULL;

#stage-to-Stage Time
WITH stage_dates AS (
    SELECT
        application_id,
        stage,
        stage_date,
        LEAD(stage) OVER (
            PARTITION BY application_id
            ORDER BY stage_date, history_id
        ) AS next_stage,
        LEAD(stage_date) OVER (
            PARTITION BY application_id
            ORDER BY stage_date, history_id
        ) AS next_stage_date
    FROM application_stage_history
)

SELECT
    stage AS from_stage,
    next_stage AS to_stage,
    COUNT(*) AS applications,
    ROUND(
        AVG(DATEDIFF(next_stage_date, stage_date)),
        2
    ) AS average_days
FROM stage_dates
WHERE next_stage IS NOT NULL
GROUP BY stage, next_stage
ORDER BY average_days DESC;

#Overall Recruitment KPIs
SELECT
    COUNT(DISTINCT a.application_id) AS total_applications,

    COUNT(DISTINCT CASE
        WHEN ash.stage = 'Hired'
        THEN ash.application_id
    END) AS total_hires,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN ash.stage = 'Hired'
            THEN ash.application_id
        END) * 100.0
        / COUNT(DISTINCT a.application_id),
        2
    ) AS hiring_conversion_rate

FROM applications a
LEFT JOIN application_stage_history ash
    ON a.application_id = ash.application_id;