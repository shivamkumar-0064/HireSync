#n average, how long does it take to hire someone from application to hiring?
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                h.stage_date,
                a.applied_date
            )
        ),
        2
    ) AS average_days_to_hire
FROM applications a
JOIN application_stage_history h
    ON a.application_id = h.application_id
WHERE h.stage = 'Hired';



#At each stage, what percentage of candidates move forward vs. drop off?
SELECT
    COUNT(DISTINCT CASE
        WHEN stage = 'Applied'
        THEN application_id
    END) AS applied,

    COUNT(DISTINCT CASE
        WHEN stage = 'Screened'
        THEN application_id
    END) AS screened,

    COUNT(DISTINCT CASE
        WHEN stage = 'Interviewed'
        THEN application_id
    END) AS interviewed,

    COUNT(DISTINCT CASE
        WHEN stage = 'Offered'
        THEN application_id
    END) AS offered,

    COUNT(DISTINCT CASE
        WHEN stage = 'Hired'
        THEN application_id
    END) AS hired
FROM application_stage_history;

#Now we calculate the actual percentages.\

SELECT
    ROUND(
        screened * 100.0 / applied,
        2
    ) AS applied_to_screened_pct,

    ROUND(
        interviewed * 100.0 / screened,
        2
    ) AS screened_to_interviewed_pct,

    ROUND(
        offered * 100.0 / interviewed,
        2
    ) AS interviewed_to_offered_pct,

    ROUND(
        hired * 100.0 / offered,
        2
    ) AS offered_to_hired_pct
FROM
(
    SELECT
        COUNT(DISTINCT CASE
            WHEN stage = 'Applied'
            THEN application_id END) AS applied,

        COUNT(DISTINCT CASE
            WHEN stage = 'Screened'
            THEN application_id END) AS screened,

        COUNT(DISTINCT CASE
            WHEN stage = 'Interviewed'
            THEN application_id END) AS interviewed,

        COUNT(DISTINCT CASE
            WHEN stage = 'Offered'
            THEN application_id END) AS offered,

        COUNT(DISTINCT CASE
            WHEN stage = 'Hired'
            THEN application_id END) AS hired

    FROM application_stage_history
) AS funnel;


#Which stage do most people drop off at?
SELECT
    ROUND(
        100 - (screened * 100.0 / applied),
        2
    ) AS applied_dropoff_pct,

    ROUND(
        100 - (interviewed * 100.0 / screened),
        2
    ) AS screening_dropoff_pct,

    ROUND(
        100 - (offered * 100.0 / interviewed),
        2
    ) AS interview_dropoff_pct,

    ROUND(
        100 - (hired * 100.0 / offered),
        2
    ) AS offer_dropoff_pct
FROM
(
    SELECT
        COUNT(DISTINCT CASE
            WHEN stage = 'Applied'
            THEN application_id END) AS applied,

        COUNT(DISTINCT CASE
            WHEN stage = 'Screened'
            THEN application_id END) AS screened,

        COUNT(DISTINCT CASE
            WHEN stage = 'Interviewed'
            THEN application_id END) AS interviewed,

        COUNT(DISTINCT CASE
            WHEN stage = 'Offered'
            THEN application_id END) AS offered,

        COUNT(DISTINCT CASE
            WHEN stage = 'Hired'
            THEN application_id END) AS hired

    FROM application_stage_history
) AS funnel;



#We can combine the previous calculations and identify the largest one.
WITH funnel AS
(
    SELECT
        COUNT(DISTINCT CASE
            WHEN stage = 'Applied'
            THEN application_id END) AS applied,

        COUNT(DISTINCT CASE
            WHEN stage = 'Screened'
            THEN application_id END) AS screened,

        COUNT(DISTINCT CASE
            WHEN stage = 'Interviewed'
            THEN application_id END) AS interviewed,

        COUNT(DISTINCT CASE
            WHEN stage = 'Offered'
            THEN application_id END) AS offered,

        COUNT(DISTINCT CASE
            WHEN stage = 'Hired'
            THEN application_id END) AS hired

    FROM application_stage_history
)

SELECT
    CASE
        WHEN 100 - (screened * 100.0 / applied)
             >= 100 - (interviewed * 100.0 / screened)
         AND 100 - (screened * 100.0 / applied)
             >= 100 - (offered * 100.0 / interviewed)
         AND 100 - (screened * 100.0 / applied)
             >= 100 - (hired * 100.0 / offered)
        THEN 'Applied → Screened'

        WHEN 100 - (interviewed * 100.0 / screened)
             >= 100 - (offered * 100.0 / interviewed)
         AND 100 - (interviewed * 100.0 / screened)
             >= 100 - (hired * 100.0 / offered)
        THEN 'Screened → Interviewed'

        WHEN 100 - (offered * 100.0 / interviewed)
             >= 100 - (hired * 100.0 / offered)
        THEN 'Interviewed → Offered'

        ELSE 'Offered → Hired'
    END AS biggest_dropoff_stage
FROM funnel;


#How does hiring performance differ between employers?
SELECT
    e.employer_id,
    e.company_name,

    COUNT(DISTINCT a.application_id) AS total_applications,

    COUNT(DISTINCT CASE
        WHEN h.stage = 'Hired'
        THEN a.application_id
    END) AS total_hired,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN h.stage = 'Hired'
            THEN a.application_id
        END) * 100.0
        /
        COUNT(DISTINCT a.application_id),
        2
    ) AS hiring_conversion_rate

FROM employers e

JOIN jobs j
    ON e.employer_id = j.employer_id

JOIN applications a
    ON j.job_id = a.job_id

LEFT JOIN application_stage_history h
    ON a.application_id = h.application_id

GROUP BY
    e.employer_id,
    e.company_name

ORDER BY
    hiring_conversion_rate DESC;
       
       
       
	