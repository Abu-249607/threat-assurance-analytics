-- ============================================================
-- Threat Assurance Analytics
-- Testing Assurance Analysis
-- ============================================================


-- 1. Combine ATT&CK techniques, mapped controls, and test outcomes
SELECT
    a.technique_id,
    a.technique_name,
    c.control_name,
    s.test_type,
    s.test_result,
    s.detected,
    s.blocked
FROM fact_security_test s
JOIN dim_attack_technique a
    ON s.technique_id = a.technique_id
LEFT JOIN bridge_control_attack b
    ON a.technique_id = b.technique_id
LEFT JOIN dim_security_control c
    ON b.control_id = c.control_id
ORDER BY a.technique_id;


-- 2. Classify assurance status based on test results
SELECT
    a.technique_id,
    a.technique_name,
    c.control_name,
    s.test_result,
    s.detected,
    s.blocked,
    CASE
        WHEN s.test_result = 'Successful'
             AND s.detected = FALSE
             AND s.blocked = FALSE
            THEN 'Critical Assurance Gap'

        WHEN s.test_result = 'Successful'
             AND s.detected = TRUE
             AND s.blocked = FALSE
            THEN 'Detected but Not Blocked'

        WHEN s.blocked = TRUE
            THEN 'Control Effective'

        ELSE 'Review Required'
    END AS assurance_status
FROM fact_security_test s
JOIN dim_attack_technique a
    ON s.technique_id = a.technique_id
LEFT JOIN bridge_control_attack b
    ON a.technique_id = b.technique_id
LEFT JOIN dim_security_control c
    ON b.control_id = c.control_id
ORDER BY a.technique_id;
-- 3. Summarize assurance statuses
SELECT
    assurance_status,
    COUNT(*) AS technique_count
FROM (
    SELECT
        CASE
            WHEN s.test_result = 'Successful'
                 AND s.detected = FALSE
                 AND s.blocked = FALSE
                THEN 'Critical Assurance Gap'

            WHEN s.test_result = 'Successful'
                 AND s.detected = TRUE
                 AND s.blocked = FALSE
                THEN 'Detected but Not Blocked'

            WHEN s.blocked = TRUE
                THEN 'Control Effective'

            ELSE 'Review Required'
        END AS assurance_status
    FROM fact_security_test s
) status_summary
GROUP BY assurance_status
ORDER BY technique_count DESC;
