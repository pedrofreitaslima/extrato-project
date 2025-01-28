import logging
import boto3

session = boto3.session.Session()
client = session.client('kafka')
ec2client = boto3.client('ec2')
s3client = boto3.client('s3')
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    logger.info(event)
    responseData = {}
    ClusterArn = event['ResourceProperties'].get('ClusterArn')
    if ClusterArn:
      try:
        ClusterArn = event['ResourceProperties']['ClusterArn']
        response = client.get_bootstrap_brokers(
            ClusterArn=ClusterArn
        )
        logger.info(response)
        if (response['ResponseMetadata']['HTTPStatusCode'] == 200):
            responseData['BootstrapBrokerStringSaslIam'] = response['BootstrapBrokerStringSaslIam']

      except Exception:
        logger.exception('Signaling failure to CloudFormation.')


    Subnetid = event['ResourceProperties'].get('privateSubnetId')
    if Subnetid:
      try:
        Subnetid = event['ResourceProperties']['privateSubnetId']
        responseec2 = ec2client.describe_subnets(SubnetIds=[Subnetid])
        logger.info(responseec2)
        if (responseec2['ResponseMetadata']['HTTPStatusCode'] == 200):
            responseData['privatesubnetAZ'] = responseec2["Subnets"][0]["AvailabilityZone"]

      except Exception:
        logger.exception('Signaling failure to CloudFormation.')