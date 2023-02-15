""" an example Python 3 lambda script to automatically configure auto scaling once the limits are reached for a web application:
In this example, the script uses the boto3 library to interact with AWS services. It sets up clients for the Auto Scaling and CloudWatch services, and then defines parameters such as the Auto Scaling group name, CloudWatch metric name, and threshold for when to trigger scaling.

The script then uses the get_metric_statistics method of the CloudWatch client to retrieve the average CPU utilization over the last 5 minutes. If the CPU utilization exceeds the threshold, the script uses the set_desired_capacity method of the Auto Scaling client to increase the desired capacity by 1.

Finally, the script prints a message indicating whether scaling is needed or not. You can schedule this script to run at regular intervals using AWS CloudWatch Events or another scheduling mechanism.


To attach the lambda solution to a web application to monitor if the limits are breached, you can use AWS CloudWatch Events to trigger the Lambda function at a specified interval, such as every 5 minutes. CloudWatch Events provides a schedule-based option that you can use to run your Lambda function automatically.

Here's an example of how you can create a CloudWatch Event Rule to trigger the Lambda function every 5 minutes:

Open the AWS Management Console and navigate to the CloudWatch service.
Click on "Events" in the left-hand navigation pane, and then click "Create rule".
Set the event source to "Schedule".
Set the schedule expression to rate(5 minutes).
Add a target to the rule, and select your Lambda function from the list of available targets.
Click "Configure details" and give the rule a name, such as "WebAppAutoScalingRule".
Click "Create rule" to create the CloudWatch Event Rule.
With this CloudWatch Event Rule in place, your Lambda function will be triggered every 5 minutes to monitor if the limits are breached.

To notify your team or take additional actions when scaling occurs, you can use Amazon SNS or EventBridge. For example, you can create an SNS topic and subscribe your team members to the topic to receive email or SMS notifications when scaling occurs. You can also use EventBridge to trigger additional AWS services, such as AWS Step Functions, to execute more complex workflows when scaling occurs.


"""


import boto3

def lambda_handler(event, context):
    # Set up AWS clients
    autoscaling = boto3.client('autoscaling')
    cloudwatch = boto3.client('cloudwatch')
    
    # Define parameters
    group_name = 'your_autoscaling_group_name'
    metric_name = 'your_cloudwatch_metric_name'
    threshold = 80
    
    # Get the average CPU utilization over the last 5 minutes
    response = cloudwatch.get_metric_statistics(
        Namespace='AWS/EC2',
        MetricName=metric_name,
        Dimensions=[
            {
                'Name': 'AutoScalingGroupName',
                'Value': group_name
            },
        ],
        StartTime=(datetime.now() - timedelta(minutes=5)).isoformat(),
        EndTime=datetime.now().isoformat(),
        Period=300,
        Statistics=['Average'],
    )
    
    # Check if the CPU utilization exceeds the threshold
    if response['Datapoints'] and response['Datapoints'][0]['Average'] > threshold:
        # Increase the desired capacity by 1
        response = autoscaling.set_desired_capacity(
            AutoScalingGroupName=group_name,
            DesiredCapacity=1,
            HonorCooldown=True,
        )
        print('Scaling up: ' + str(response))
    else:
        print('No scaling needed')

        
