import sys

sys.path.append("/opt/airflow")

from datetime import datetime

from airflow import DAG
from airflow.providers.standard.operators.python import PythonOperator

from include.fivetran import trigger_sync, wait_for_sync

from include.dbt_cloud_api import run_dbt_job


CONNECTOR_ID = "dandelion_greenish"


with DAG(
    dag_id="flights_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
) as dag:

    trigger_fivetran_sync = PythonOperator(
        task_id="trigger_fivetran_sync",
        python_callable=trigger_sync,
        op_kwargs={
            "connector_id": CONNECTOR_ID,
        },
    )

    wait_for_fivetran_sync = PythonOperator(
        task_id="wait_for_fivetran_sync",
        python_callable=wait_for_sync,
        op_kwargs={
            "connector_id": CONNECTOR_ID,
        },
    )
    
    run_dbt = PythonOperator(
    task_id="run_dbt_job",
    python_callable=run_dbt_job,
    )

    trigger_fivetran_sync >> wait_for_fivetran_sync >> run_dbt