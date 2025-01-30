import boto3
import logging


logger = logging.getLogger()
logger.setLevel(logging.INFO)
session = boto3.session.Session(region_name='us-east-1')


def lambda_handler(event, context):
    try:
        # Extract parameters from the event
        iam_role = event.get('IamRole')
        bucket_name = event.get('BucketName')

        if not all([iam_role, bucket_name]):
            raise ValueError("Missing required parameters in event")

        # Initialize S3 client
        s3 = session.resource('s3')
        bucket = s3.Bucket(bucket_name)
        for obj in bucket.objects.filter():
            s3.Object(bucket.name, obj.key).delete()

        # Initialize IAM client
        iam = session.client('iam')
        attached_policies = iam.list_attached_role_policies(RoleName=iam_role)
        for policy in attached_policies['AttachedPolicies']:
            iam.detach_role_policy(RoleName=iam_role, PolicyArn=policy['PolicyArn'])

        logger.info(f"Successfully deleted all objects in S3 bucket: {bucket_name}")
        logger.info(f"Successfully deattached all policy in IAM role: {iam_role}")

        return {
            'statusCode': 200,
            'body': {
                'message': 'Clean up S3 and IAM Role deleted and deattached successfully',
                's3_bucket_name': bucket,
                'iam_role': iam_role
            }
        }

    except Exception as e:
        logger.error(f"Error validating clean up S3 and IAM: {str(e)}")
        return {
            'statusCode': 500,
            'body': {
                'message': f"Error validating clean up S3 and IAM: {str(e)}"
            }
        }


if __name__ == "__main__":
    event = {
        "BucketName": "aws-gluescript-extrato-lancamento-efetivado",
        "IamRole": "extrato-lancamento-efetivado-glue-msk-getbroker-role"
    }

    context = {

    }

    lambda_handler(event, context)