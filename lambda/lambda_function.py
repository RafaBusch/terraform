"""
agradecimento especial ao Samuell wagner por ter colaborado no código

esse código atualiza as permissoes que a policy tem
"""
import json, boto3

def create_iam_policy_json():
    # Create a policy
    my_managed_policy = {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject",
                    "s3:PutBucketNotification",
                    "s3:PutBucketPolicy",
                    "s3:CreateBucket",
                    "s3:GetBucketPolicy"
                ],
                "Resource": [
                    "arn:aws:s3:::*/*",
                ]
            }
        ]
    }

    return my_managed_policy

def attach_user_policy(policy, policy_arn="arn:aws:iam::431591413306:policy/testS3Policy", username="teste-s3-deny-access"):
    iam = boto3.client("iam")

    response = iam.create_policy_version(
        PolicyArn = "arn:aws:iam::431591413306:policy/testS3Policy",
        PolicyDocument=json.dumps(policy),
        SetAsDefault = True
    )
    print(response)

    response = iam.attach_user_policy(
        UserName = "teste-s3-deny-access",
        PolicyArn = "arn:aws:iam::431591413306:policy/testS3Policy"
    )
    print(response)

def lambda_handler(event, context):
    policy = create_iam_policy_json()
    attach_user_policy(policy=policy)
    return {
        'statusCode': 200,
        'body': json.dumps('update succeed')
    }