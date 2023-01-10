"""
You could also use AWS EventBridge for scheduling the Lambda function to run at specific intervals, and you may want to tweak this based on your specific use case and requirements


"""

import boto3
from datetime import datetime, timedelta

def schedule_lambda_function(function_name, rule_name, schedule_expression):
    events = boto3.client('events')
    lambda_ = boto3.client('lambda')

    # Create the event rule
    events.put_rule(
        Name=rule_name,
        ScheduleExpression=schedule_expression
    )

    # Create the event target
    events.put_targets(
        Rule=rule_name,
        Targets=[{
            'Id': '1',
            'Arn': lambda_.get_function(FunctionName=function_name)['Configuration']['FunctionArn']
        }]
    )

def stop_lambda(event, context):
    ...
    
schedule_expression = "cron(0 9 * * ? *)" # this will run the lambda every day at 9AM UTC
schedule_lambda_function("stop_lambda", "stop_lambda_rule", schedule_expression)
