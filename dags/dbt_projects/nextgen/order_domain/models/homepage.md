{% docs __overview__ %}
This ELT Development Project is based on the **Medallion Architecture** concept. The Medallion Architecture is a data architecture approach focused on organizing and managing data in stages or "layers," typically consisting of Bronze, Silver, and Gold layers.

### Tools Used:
- **Snowflake**: Our cloud data warehouse that stores and processes data.
- **dbt**: A data transformation tool used to build and manage our SQL-based transformation pipelines.
- **Airflow**: Orchestrates the entire ELT pipeline, scheduling and automating tasks in the data workflow.

The goal of this project is to process raw data (Bronze layer), clean and standardize it (Silver layer), and ultimately create high-quality, business-ready datasets (Gold layer) for reporting and analytics.
{% enddocs %}
