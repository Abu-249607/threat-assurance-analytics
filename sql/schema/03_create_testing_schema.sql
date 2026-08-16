CREATE TABLE fact_security_test (
    test_id VARCHAR(20) PRIMARY KEY,
    technique_id VARCHAR(20) NOT NULL,
    test_type VARCHAR(50) NOT NULL,
    test_result VARCHAR(50) NOT NULL,
    detected BOOLEAN NOT NULL,
    blocked BOOLEAN NOT NULL,
    test_date DATE NOT NULL,

    FOREIGN KEY (technique_id)
        REFERENCES dim_attack_technique(technique_id)
);
