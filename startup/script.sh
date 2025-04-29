#!/bin/sh

echo "------------------------------"
echo "Installing virtual Python env"
echo "------------------------------"

export DBT_VENV_PATH="${AIRFLOW_HOME}/dbt_venv"
export DBT_PROJECT_PATH="${AIRFLOW_HOME}/dags"

pip3 install --upgrade pip

echo "Current Python version:"
python3 --version 
echo "..."

python3 -m venv "${DBT_VENV_PATH}"

echo "------------------------------"
echo "Activating venv in"

source ${DBT_VENV_PATH}/bin/activate
pip3 list

echo "------------------------------"
echo "Installing libraries..."
echo "------------------------------"

pip3 install dbt-core==1.8.5 dbt-redshift dbt-athena-community dbt-dremio dbt-snowflake

echo "------------------------------"
echo "Venv libraries..."
echo "------------------------------"

pip3 list
dbt --version

echo "------------------------------"
echo "Deactivating venv..."
echo "------------------------------"

deactivate