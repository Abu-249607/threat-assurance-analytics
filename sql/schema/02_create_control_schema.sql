CREATE TABLE dim_security_control (
    control_id VARCHAR(20) PRIMARY KEY,
    control_name VARCHAR(255) NOT NULL,
    technology VARCHAR(100) NOT NULL,
    control_type VARCHAR(50) NOT NULL,
    control_owner VARCHAR(150),
    status VARCHAR(50) NOT NULL
);

CREATE TABLE bridge_control_attack (
    control_id VARCHAR(20) NOT NULL,
    technique_id VARCHAR(20) NOT NULL,

    PRIMARY KEY (control_id, technique_id),

    FOREIGN KEY (control_id)
        REFERENCES dim_security_control(control_id),

    FOREIGN KEY (technique_id)
        REFERENCES dim_attack_technique(technique_id)
);
