import base64
import json
import functions_framework
import requests
import logging
import time
from cloudevents.http import CloudEvent

# Configure the logging settings
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

SWAPBOARD_API_URL = "https://tmwork.net/api/shift/swapboard"
POST_URL = "https://tmwork.net/api/shift/swap/claim"

def fetch_shifts(shift_start_date, shift_range, cookie, x_api_token):
    response = requests.get(url=SWAPBOARD_API_URL, params={'date': shift_start_date, 'range': shift_range}, headers={'Cookie': cookie, 'x-api-token': x_api_token})
    return response.json()

def claim_shift(user_id, shift_id, cookie, x_api_token):
    response = requests.put(url=POST_URL, params={'id': user_id, 'bid': "3557", 'schid': shift_id}, headers={'Cookie': cookie, 'x-api-token': x_api_token})
    return "Shift not found" not in response.text

def process_shifts(shifts, shift_start_date, preferred_shift_groups, cookie, x_api_token):
    for item in sorted(shifts, key=lambda i: i['SchId'], reverse=True):
        if item["ShiftGroup"] in preferred_shift_groups and item["Date"] >= shift_start_date:
            success = claim_shift(item["Id"], item["SchId"], cookie, x_api_token)
            if success:
                logger.info(f"Shift ID: {item['SchId']} claimed successfully")
            else:
                logger.error(f"Failed to claim shift ID: {item['SchId']}")

@functions_framework.cloud_event
def claim_shifts(cloud_event: CloudEvent):
    message_data = json.loads(base64.b64decode(cloud_event.data['message']['data']).decode('utf-8'))

    shift_start_date, preferred_shift_groups, shift_range, cookie, x_api_token = [message_data.get(key) for key in ['shift_start_date', 'preferred_shift_groups', 'shift_range', 'cookie', 'x_api_token']]
    shift_range = shift_range or 'week'
    user_preferred_shift_groups = [group.strip() for group in preferred_shift_groups.split(',')]

    while True:
        time.sleep(5)
        shifts = fetch_shifts(shift_start_date, shift_range, cookie, x_api_token)
        if not shifts:
            logger.info("No shifts available.")
        else:
            process_shifts(shifts, shift_start_date, user_preferred_shift_groups, cookie, x_api_token)
