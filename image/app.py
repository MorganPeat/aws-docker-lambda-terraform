"""Python lambda handler

This script handles calls from AWS lambda. It simply returns a json document with HTTP OK (200) status, with
the current AWS region in the body.

For more details see https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html

"""

import os
import json


def handler(event, context):
    json_region = os.environ['AWS_REGION']
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "Region ": json_region
        })
    }
