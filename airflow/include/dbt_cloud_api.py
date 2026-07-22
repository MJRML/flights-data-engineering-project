import time

import requests

from airflow.hooks.base import BaseHook

DBT_CLOUD_API = "https://su810.us1.dbt.com/api/v2"


def get_dbt_connection():
    """
    Retrieve the dbt Cloud connection.
    """
    return BaseHook.get_connection("dbt_cloud_default")


def get_dbt_headers():
    """
    Build the headers for the dbt Cloud API.
    """
    conn = get_dbt_connection()

    return {
        "Authorization": f"Token {conn.password}",
        "Content-Type": "application/json",
    }


def get_dbt_config():
    """
    Retrieve the dbt Cloud Account ID and Job ID.
    """
    conn = get_dbt_connection()

    return (
        conn.extra_dejson["account_id"],
        conn.extra_dejson["job_id"],
    )


def run_dbt_job():
    """
    Trigger a dbt Cloud job.
    """

    account_id, job_id = get_dbt_config()

    url = (
        f"{DBT_CLOUD_API}/accounts/"
        f"{account_id}/jobs/"
        f"{job_id}/run/"
    )

    response = requests.post(
        url,
        headers=get_dbt_headers(),
        json={
            "cause": "Triggered via Airflow",
        },
    timeout=30,
)

    response.raise_for_status()

    run_id = response.json()["data"]["id"]

    print(f"Triggered dbt Cloud job. Run ID: {run_id}")

    return run_id