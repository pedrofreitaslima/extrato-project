import boto3
import json
import logging


logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    try:
        # Extract parameters from the event
        cluster_arn = event.get('ClusterArn')
        private_subnet_id = event.get('privateSubnetId')
        s3_bucket = event.get('S3BucketForGlueScriptCopy')

        if not all([cluster_arn, private_subnet_id, s3_bucket]):
            raise ValueError("Missing required parameters in event")

        # Initialize Kafka client
        kafka_client = boto3.client('kafka')

        # Get bootstrap broker information
        response = kafka_client.get_bootstrap_brokers(
            ClusterArn=cluster_arn
        )

        # Get the bootstrap broker strings
        bootstrap_brokers = response.get('BootstrapBrokerStringSaslIam')

        if not bootstrap_brokers:
            raise Exception("No bootstrap brokers found for the cluster")

        # Store bootstrap brokers in S3
        s3_client = boto3.client('s3')
        bootstrap_config = {
            'bootstrapServers': bootstrap_brokers,
            'privateSubnetId': private_subnet_id
        }

        # Save the configuration to S3
        s3_client.put_object(
            Bucket=s3_bucket,
            Key='msk-config/bootstrap-config.json',
            Body=json.dumps(bootstrap_config),
            ContentType='application/json'
        )

        logger.info(f"Successfully validated and stored bootstrap configuration for cluster: {cluster_arn}")

        return {
            'statusCode': 200,
            'body': {
                'message': 'Bootstrap brokers validated and stored successfully',
                'bootstrapBrokers': bootstrap_brokers,
                'configLocation': f"s3://{s3_bucket}/msk-config/bootstrap-config.json"
            }
        }

    except Exception as e:
        logger.error(f"Error validating bootstrap brokers: {str(e)}")
        return {
            'statusCode': 500,
            'body': {
                'message': f"Error validating bootstrap brokers: {str(e)}"
            }
        }
