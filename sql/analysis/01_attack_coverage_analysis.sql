-- Count active ATT&CK techniques by tactic
SELECT
    t.tactic_name,
    COUNT(DISTINCT b.technique_id) AS technique_count
FROM dim_tactic t
JOIN bridge_technique_tactic b
    ON t.tactic_id = b.tactic_id
GROUP BY t.tactic_name
ORDER BY technique_count DESC;


-- Count active ATT&CK techniques by platform
SELECT
    p.platform_name,
    COUNT(DISTINCT b.technique_id) AS technique_count
FROM dim_platform p
JOIN bridge_technique_platform b
    ON p.platform_id = b.platform_id
GROUP BY p.platform_name
ORDER BY technique_count DESC;

