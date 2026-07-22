import time

import requests
from requests.auth import HTTPBasicAuth

from airflow.hooks.base import BaseHook

FIVETRAN_API = "https://api.fivetran.com/v1"


def get_fivetran_auth():
    """
    Retrieve the Fivetran API credentials from the Airflow Connection.
    """

    conn = BaseHook.get_connection("fivetran_default")

    return HTTPBasicAuth(
        conn.login,
        conn.password,
    )


def trigger_sync(connector_id: str):
    """
    Trigger an immediate sync for a Fivetran connector.
    """

    print(f"Triggering Fivetran sync for connector '{connector_id}'...")

    url = f"{FIVETRAN_API}/connectors/{connector_id}/force"

    response = requests.post(
        url,
        auth=get_fivetran_auth(),
        timeout=30,
    )

    response.raise_for_status()

    print("Sync successfully triggered.")

    return response.json()

def wait_for_sync(connector_id: str):
    """
    Wait until the Fivetran connector has finished syncing.
    """

    url = f"{FIVETRAN_API}/connectors/{connector_id}"

    while True:

        response = requests.get(
            url,
            auth=get_fivetran_auth(),
            timeout=30,
        )

        response.raise_for_status()

        data = response.json()["data"]
        sync_state = data["status"]["sync_state"]

        print(f"Current sync state: {sync_state}")
        
        if sync_state == "paused":
            raise Exception("Fivetran connector is paused.")

        if sync_state == "scheduled":
            print("Fivetran sync completed.")
            return

        time.sleep(30)