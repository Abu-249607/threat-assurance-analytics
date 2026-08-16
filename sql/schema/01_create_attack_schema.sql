CREATE TABLE dim_attack_technique (
    technique_id VARCHAR(20) PRIMARY KEY,
    technique_name VARCHAR(255) NOT NULL,
    description TEXT,
    is_subtechnique BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ,
    modified_at TIMESTAMPTZ,
    deprecated BOOLEAN NOT NULL,
    revoked BOOLEAN NOT NULL
);

CREATE TABLE dim_tactic (
    tactic_id SERIAL PRIMARY KEY,
    tactic_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE bridge_technique_tactic (
    technique_id VARCHAR(20) NOT NULL,
    tactic_id INTEGER NOT NULL,

    PRIMARY KEY (technique_id, tactic_id),

    FOREIGN KEY (technique_id)
        REFERENCES dim_attack_technique(technique_id),

    FOREIGN KEY (tactic_id)
        REFERENCES dim_tactic(tactic_id)
);

CREATE TABLE dim_platform (
    platform_id SERIAL PRIMARY KEY,
    platform_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE bridge_technique_platform (
    technique_id VARCHAR(20) NOT NULL,
    platform_id INTEGER NOT NULL,

    PRIMARY KEY (technique_id, platform_id),

    FOREIGN KEY (technique_id)
        REFERENCES dim_attack_technique(technique_id),

    FOREIGN KEY (platform_id)
        REFERENCES dim_platform(platform_id)
);
