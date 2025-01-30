import json
import base64
import os
from kafka import KafkaProducer
from kafka.errors import KafkaError
from aws_msk_iam_sasl_signer import MSKAuthTokenProvider


class MSKTokenProvider:
    def token(self):
        token, _ = MSKAuthTokenProvider.generate_auth_token(os.environ['AWS_REGION'])
        return token


def create_kafka_producer():
    # Get bootstrap servers from environment variable
    bootstrap_servers = os.environ['BOOTSTRAP_SERVERS'].split(',')

    # Create producer with SASL/IAM authentication
    producer = KafkaProducer(
        bootstrap_servers=bootstrap_servers,
        security_protocol='SASL_SSL',
        sasl_mechanism='OAUTHBEARER',
        sasl_oauth_token_provider=MSKTokenProvider(),
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )
    return producer


def lambda_handler(event, context):
    try:
        # Create Kafka producer
        producer = create_kafka_producer()

        # Topic name from environment variable
        topic = os.environ['KAFKA_TOPIC']

        # Sample message to send
        message = {
            "message": "Hello from Lambda!",
            "timestamp": str(context.get_remaining_time_in_millis())
        }

        # Send message to Kafka topic
        future = producer.send(topic, value=message)

        # Wait for message to be delivered
        record_metadata = future.get(timeout=10)

        # Close the producer
        producer.close()

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Message sent successfully',
                'topic': record_metadata.topic,
                'partition': record_metadata.partition,
                'offset': record_metadata.offset
            })
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }

