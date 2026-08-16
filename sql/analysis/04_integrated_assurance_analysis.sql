SELECT
    a.technique_id,
    a.technique_name,
    c.control_name,
    s.test_result,
    s.detected AS test_detected,
    s.blocked,
    d.alert_enabled,
    d.validated,
    CASE
        WHEN s.test_result = 'Successful'
             AND s.detected = FALSE
             AND s.blocked = FALSE
             AND d.validated = FALSE
            THEN 'Critical Assurance Gap'

        WHEN s.test_result = 'Successful'
             AND s.detected = TRUE
             AND s.blocked = FALSE
             AND d.validated = TRUE
            THEN 'Detected but Not Blocked'

        WHEN s.blocked = TRUE
             AND d.validated = TRUE
            THEN 'Control Effective'

        ELSE 'Review Required'
    END AS assurance_status
FROM dim_attack_technique a
JOIN fact_security_test s
    ON a.technique_id = s.technique_id
LEFT JOIN bridge_control_attack b
    ON a.technique_id = b.technique_id
LEFT JOIN dim_security_control c
    ON b.control_id = c.control_id
LEFT JOIN fact_detection_coverage d
    ON a.technique_id = d.technique_id
ORDER BY a.technique_id;
-- 2. Summarize integrated assurance status counts
SELECT
    assurance_status,
    COUNT(*) AS technique_count
FROM (
    SELECT
        CASE
            WHEN s.test_result = 'Successful'
                 AND s.detected = FALSE
                 AND s.blocked = FALSE
                 AND d.validated = FALSE
                THEN 'Critical Assurance Gap'

            WHEN s.test_result = 'Successful'
                 AND s.detected = TRUE
                 AND s.blocked = FALSE
                 AND d.validated = TRUE
                THEN 'Detected but Not Blocked'

            WHEN s.blocked = TRUE
                 AND d.validated = TRUE
                THEN 'Control Effective'

            ELSE 'Review Required'
        END AS assurance_status
    FROM dim_attack_technique a
    JOIN fact_security_test s
        ON a.technique_id = s.technique_id
    LEFT JOIN fact_detection_coverage d
        ON a.technique_id = d.technique_id
) assurance_summary
GROUP BY assurance_status
ORDER BY technique_count DESC;
