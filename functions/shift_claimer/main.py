import base64
import json
import functions_framework

@functions_framework.cloud_event
def shift_claimer(cloud_event):
    try:
        message_data = base64.b64decode(cloud_event.data['message']['data']).decode('utf-8')
        message_json = json.loads(message_data)
        action = message_json['action']
        shift_id = message_json['shift_id']

    except (json.JSONDecodeError, KeyError) as e:
        print(f"Error processing message: {str(e)}")

