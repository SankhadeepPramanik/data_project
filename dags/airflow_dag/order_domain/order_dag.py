import os
import json
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from cosmos import DbtTaskGroup, ProfileConfig, ProjectConfig, ExecutionConfig, RenderConfig
from cosmos.constants import ExecutionMode
from datetime import datetime, timedelta
from dags.nextgen.order.include.notifications import notify_teams
from airflow.models import Variable
from airflow.utils.dates import days_ago
from airflow.utils.trigger_rule import TriggerRule

Project_name = 'order'
dag_id="ETL_Dremio_Order_SCD2_Table_Refresh"
run_id = "{{ run_id }}"

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

# Retrieve the email alert list from the Airflow Variable
email_list_str = Variable.get("EMAIL_LIST")  # Get the JSON string
email_list = json.loads(email_list_str)  # Convert to a Python list

def starting():
    print(" DBT JOB Started.........")
    
def ending():
    print("DBT JOB Successfully Completed.....")

 
def always_runs():
    print("master table refresh completed and control table reffresh starting....")
 
default_args = {
    'owner': 'NextGen',
    'depends_on_past': False,
    'email_on_failure': True,
    'email_on_retry': False,
    'email': email_list,
    'retries': 2,
    'retry_delay': timedelta(minutes=2),
    'on_failure_callback': notify_teams,
}

with DAG(
    dag_id=f"{dag_id}",
    start_date=datetime(2024, 9, 1),
    schedule_interval='10,40 * * * *',
    catchup=False,
    max_active_runs=1,
    concurrency=3,
    tags=["dremio", "DBT","ETL","Order"],
    default_args=default_args
) as dag:
    start = PythonOperator(task_id='start', python_callable=starting, dag=dag)

    dbt_task = DbtTaskGroup(
        execution_config=execution_config,
        profile_config=profile_config,
        project_config=project_config,
        operator_args={
                "install_deps": True,
                "vars":f'{{"dag_id": {dag_id},"dag_run_id": "{ run_id }" }}',
            },
        render_config=RenderConfig(
            select=["tag:order_scd2_table"],
          ),
        group_id="order_master_table_refresh"  # Unique group_id

    )

    log_info = PythonOperator(
        task_id='log_info',
        python_callable=always_runs,
        trigger_rule=TriggerRule.ALL_DONE, 
    )
    
    
    dbt_task1 = DbtTaskGroup(
        execution_config=execution_config,
        profile_config=profile_config,
        project_config=project_config,
        operator_args={
                "install_deps": True,
                "vars":f'{{"dag_id": {dag_id},"dag_run_id": "{ run_id }" }}',
            },
        render_config=RenderConfig(
            select=["tag:order_scd2_cntrl_table"],
        ),
        group_id="order_control_table_refresh"  # Unique group_id

    )
    
    end = PythonOperator(task_id='end', python_callable=ending, dag=dag)

    start >> dbt_task>>log_info>>dbt_task1 >> end
