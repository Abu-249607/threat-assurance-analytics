CREATE OR REPLACE VIEW vw_powerbi_assurance_detail AS
SELECT
    v.technique_id,
    v.technique_name,
    t.tactic_name,

    v.control_id,
    v.control_name,
    v.control_technology,
    v.control_type,

    v.test_id,
    v.test_type,
    v.test_result,
    v.test_detected,
    v.blocked,
    v.test_date,

    v.detection_id,
    v.detection_name,
    v.detection_technology,
    v.telemetry_available,
    v.alert_enabled,
    v.validated,
    v.last_validated,

    v.assurance_status

FROM vw_assurance_posture v

JOIN bridge_technique_tactic btt
    ON v.technique_id = btt.technique_id

JOIN dim_tactic t
    ON btt.tactic_id = t.tactic_id;
