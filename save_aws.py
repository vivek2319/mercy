import boto3
import pytz
from datetime import datetime

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    rds = boto3.client('rds')
    
    # Set the time zone for IST and PST
    IST = pytz.timezone('Asia/Kolkata')
    PST = pytz.timezone('America/Los_Angeles')
    
    # Get the current time in IST and PST
    now_ist = datetime.now(IST)
    now_pst = datetime.now(PST)
    
    # Check if the current time is outside of the specified hours
    if (now_ist.hour < 9 or now_ist.hour >= 18) and (now_pst.hour < 9 or now_pst.hour >= 18):
        # Get a list of all running EC2 instances
        ec2_instances = ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
        for instance in ec2_instances['Reservations']:
            for i in instance['Instances']:
                ec2.stop_instances(InstanceIds=[i['InstanceId']])
                
        # Get a list of all running RDS instances
        rds_instances = rds.describe_db_instances()
        for instance in rds_instances['DBInstances']:
            if instance['DBInstanceStatus'] == 'available':
                rds.stop_db_instance(DBInstanceIdentifier=instance['DBInstanceIdentifier'])

