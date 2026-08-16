-- ============================================================
-- Threat Assurance Analytics
-- Control Coverage Analysis
-- ============================================================


-- 1. Count ATT&CK techniques without a mapped security control
SELECT
    COUNT(*) AS unmapped_techniques
FROM dim_attack_technique a
LEFT JOIN bridge_control_attack b
    ON a.technique_id = b.technique_id
WHERE b.control_id IS NULL;


-- 2. Calculate overall ATT&CK control coverage
SELECT
    COUNT(DISTINCT b.technique_id) AS mapped_techniques,
    COUNT(DISTINCT a.technique_id) AS total_techniques,
    ROUND(
        COUNT(DISTINCT b.technique_id) * 100.0
        / NULLIF(COUNT(DISTINCT a.technique_id), 0),
        2
    ) AS coverage_percentage
FROM dim_attack_technique a
LEFT JOIN bridge_control_attack b
    ON a.technique_id = b.technique_id;


-- 3. Calculate control coverage by ATT&CK tactic
SELECT
    t.tactic_name,
    COUNT(DISTINCT btt.technique_id) AS total_techniques,
    COUNT(DISTINCT bca.technique_id) AS mapped_techniques,
    ROUND(
        COUNT(DISTINCT bca.technique_id) * 100.0
        / NULLIF(COUNT(DISTINCT btt.technique_id), 0),
        2
    ) AS coverage_percentage
FROM dim_tactic t
JOIN bridge_technique_tactic btt
    ON t.tactic_id = btt.tactic_id
LEFT JOIN bridge_control_attack bca
    ON btt.technique_id = bca.technique_id
GROUP BY t.tactic_name
ORDER BY coverage_percentage DESC;
