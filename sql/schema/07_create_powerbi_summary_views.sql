CREATE OR REPLACE VIEW vw_powerbi_assurance_summary AS
SELECT
    assurance_status,
    COUNT(DISTINCT technique_id) AS technique_count
FROM vw_assurance_posture
GROUP BY assurance_status;


CREATE OR REPLACE VIEW vw_powerbi_tactic_summary AS
SELECT
    tactic_name,
    assurance_status,
    COUNT(DISTINCT technique_id) AS technique_count
FROM vw_assurance_posture_by_tactic
GROUP BY
    tactic_name,
    assurance_status;


CREATE OR REPLACE VIEW vw_powerbi_detection_summary AS
SELECT
    detection_technology,
    COUNT(DISTINCT technique_id) AS techniques_covered,
    COUNT(DISTINCT CASE
        WHEN validated = TRUE THEN technique_id
    END) AS validated_techniques,
    COUNT(DISTINCT CASE
        WHEN alert_enabled = TRUE THEN technique_id
    END) AS alert_enabled_techniques
FROM vw_assurance_posture
GROUP BY detection_technology;


CREATE OR REPLACE VIEW vw_powerbi_control_summary AS
SELECT
    control_technology,
    control_type,
    COUNT(DISTINCT technique_id) AS techniques_covered
FROM vw_assurance_posture
GROUP BY
    control_technology,
    control_type;
