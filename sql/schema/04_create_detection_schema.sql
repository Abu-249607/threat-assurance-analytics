CREATE TABLE fact_detection_coverage (
    detection_id VARCHAR(20) PRIMARY KEY,
    technique_id VARCHAR(20) NOT NULL,
    detection_name VARCHAR(255) NOT NULL,
    technology VARCHAR(100) NOT NULL,
    telemetry_available BOOLEAN NOT NULL,
    alert_enabled BOOLEAN NOT NULL,
    validated BOOLEAN NOT NULL,
    last_validated DATE,

    FOREIGN KEY (technique_id)
        REFERENCES dim_attack_technique(technique_id)
);
