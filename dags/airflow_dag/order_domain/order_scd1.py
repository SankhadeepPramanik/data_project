import os
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from cosmos import DbtTaskGroup, ProfileConfig, ProjectConfig, ExecutionConfig, RenderConfig
from cosmos.constants import ExecutionMode
from datetime import datetime, timedelta
from airflow.models import Variable

Project_name = 'order'

dbt_project_path=os.getenv('DBT_PROJECT_PATH','/usr/local/airflow/dags')
dbt_venv_path=os.getenv('DBT_VENV_PATH','/usr/local/airflow/dbt_venv')

profile_config = ProfileConfig(
    profile_name="dremio_connections",
    target_name=Variable.get("Dremio_env", default_var=None),
    profiles_yml_filepath=f"{dbt_project_path}/projects/profiles.yml",
)

execution_config = ExecutionConfig(
    dbt_executable_path=f"{dbt_venv_path}/bin/dbt",
)

project_config = ProjectConfig(
        dbt_project_path=f"{dbt_project_path}/projects/nextgen/{Project_name}",
    )


def starting():
    print(" DBT JOB Started.........")
    
def ending():
    print("DBT JOB Successfully Completed.....")


default_args = {
    'owner': 'NextGen',
    'depends_on_past': False,
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 2,
    'retry_delay': timedelta(minutes=2)
}

with DAG(
    dag_id="ETL_Dremio_Order_SCD1_Table_Refresh",
    start_date=datetime(2024, 9, 1),
    schedule_interval='*/30 * * * *',
    catchup=False,
    max_active_runs=1,
    concurrency=5,
    tags=["dremio", "DBT","ETL"],
    default_args=default_args
) as dag:
    start = PythonOperator(task_id='start', python_callable=starting, dag=dag)

    dbt_task = DbtTaskGroup(
        execution_config=execution_config,
        profile_config=profile_config,
        project_config=project_config,
        operator_args={
                "install_deps": True
            },
        render_config=RenderConfig(
            select=["tag:order_scd1_table"],
        )
    )

    end = PythonOperator(task_id='end', python_callable=ending, dag=dag)

    start >> dbt_task >> end