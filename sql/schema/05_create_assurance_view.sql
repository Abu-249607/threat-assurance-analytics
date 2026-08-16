CREATE OR REPLACE VIEW vw_assurance_posture AS
SELECT
    a.technique_id,
    a.technique_name,

    c.control_id,
    c.control_name,
    c.technology AS control_technology,
    c.control_type,

    s.test_id,
    s.test_type,
    s.test_result,
    s.detected AS test_detected,
    s.blocked,
    s.test_date,

    d.detection_id,
    d.detection_name,
    d.technology AS detection_technology,
    d.telemetry_available,
    d.alert_enabled,
    d.validated,
    d.last_validated,

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
    ON a.technique_id = d.technique_id;
