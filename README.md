# Threat Assurance Analytics

A threat-informed cybersecurity analytics project using MITRE ATT&CK, Python, SQL, and Power BI to evaluate security control coverage, testing results, detection gaps, and enterprise security posture.

## Project Goal

The goal of this project is to build an end-to-end threat assurance analytics platform that combines:

- MITRE ATT&CK threat intelligence
- Security control mappings
- Red and Purple Team testing results
- SOC and detection coverage
- Assurance scoring
- Power BI reporting

## Technology Stack

- Python
- pandas
- SQL
- PostgreSQL
- Power BI
- MITRE ATT&CK

## Project Structure

- `data/raw/` — Original source data
- `data/processed/` — Cleaned and transformed datasets
- `data/synthetic/` — Synthetic security control and testing datasets
- `notebooks/` — Exploratory analysis and development notebooks
- `src/extract/` — Data ingestion scripts
- `src/transform/` — Data transformation scripts
- `src/scoring/` — Assurance scoring logic
- `sql/schema/` — Database table definitions
- `sql/analysis/` — Analytical SQL queries
- `powerbi/` — Power BI dashboard files
- `docs/` — Data dictionaries, methodology, and project documentation

## Current Status

Project initialization complete.

Next milestone: ingest and explore the MITRE ATT&CK Enterprise dataset.
