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
                    "s3:ListAccessPointsForObjectLambda",
                    "s3:DeleteAccessPoint",
                    "s3:DeleteAccessPointForObjectLambda",
                    "s3:PutLifecycleConfiguration",
                    "s3:DeleteObject",
                    "s3:CreateMultiRegionAccessPoint",
                    "s3:GetBucketWebsite",
                    "s3:GetMultiRegionAccessPoint",
                    "s3:PutReplicationConfiguration",
                    "s3:GetObjectAttributes",
                    "s3:InitiateReplication",
                    "s3:GetObjectLegalHold",
                    "s3:GetBucketNotification",
                    "s3:GetReplicationConfiguration",
                    "s3:DescribeMultiRegionAccessPointOperation",
                    "s3:PutObject",
                    "s3:PutBucketNotification",
                    "s3:CreateJob",
                    "s3:PutBucketObjectLockConfiguration",
                    "s3:GetStorageLensDashboard",
                    "s3:GetLifecycleConfiguration",
                    "s3:GetBucketTagging",
                    "s3:GetInventoryConfiguration",
                    "s3:GetAccessPointPolicyForObjectLambda",
                    "s3:ListBucket",
                    "s3:AbortMultipartUpload",
                    "s3:UpdateJobPriority",
                    "s3:DeleteBucket",
                    "s3:PutBucketVersioning",
                    "s3:GetMultiRegionAccessPointPolicyStatus",
                    "s3:ListBucketMultipartUploads",
                    "s3:PutIntelligentTieringConfiguration",
                    "s3:PutMetricsConfiguration",
                    "s3:GetBucketVersioning",
                    "s3:GetAccessPointConfigurationForObjectLambda",
                    "s3:PutInventoryConfiguration",
                    "s3:GetMultiRegionAccessPointRoutes",
                    "s3:GetStorageLensConfiguration",
                    "s3:DeleteStorageLensConfiguration",
                    "s3:GetAccountPublicAccessBlock",
                    "s3:PutBucketWebsite",
                    "s3:ListAllMyBuckets",
                    "s3:PutBucketRequestPayment",
                    "s3:PutObjectRetention",
                    "s3:CreateAccessPointForObjectLambda",
                    "s3:GetBucketCORS",
                    "s3:GetObjectVersion",
                    "s3:PutAnalyticsConfiguration",
                    "s3:PutAccessPointConfigurationForObjectLambda",
                    "s3:GetObjectVersionTagging",
                    "s3:PutStorageLensConfiguration",
                    "s3:CreateBucket",
                    "s3:GetStorageLensConfigurationTagging",
                    "s3:ReplicateObject",
                    "s3:GetObjectAcl",
                    "s3:GetBucketObjectLockConfiguration",
                    "s3:DeleteBucketWebsite",
                    "s3:GetIntelligentTieringConfiguration",
                    "s3:GetObjectVersionAcl",
                    "s3:GetBucketPolicyStatus",
                    "s3:GetObjectRetention",
                    "s3:GetJobTagging",
                    "s3:ListJobs",
                    "s3:PutObjectLegalHold",
                    "s3:PutBucketCORS",
                    "s3:ListMultipartUploadParts",
                    "s3:GetObject",
                    "s3:DescribeJob",
                    "s3:PutBucketLogging",
                    "s3:GetAnalyticsConfiguration",
                    "s3:GetObjectVersionForReplication",
                    "s3:GetAccessPointForObjectLambda",
                    "s3:CreateAccessPoint",
                    "s3:GetAccessPoint",
                    "s3:PutAccelerateConfiguration",
                    "s3:SubmitMultiRegionAccessPointRoutes",
                    "s3:DeleteObjectVersion",
                    "s3:GetBucketLogging",
                    "s3:ListBucketVersions",
                    "s3:RestoreObject",
                    "s3:GetAccelerateConfiguration",
                    "s3:GetObjectVersionAttributes",
                    "s3:GetBucketPolicy",
                    "s3:PutEncryptionConfiguration",
                    "s3:GetEncryptionConfiguration",
                    "s3:GetObjectVersionTorrent",
                    "s3:GetBucketRequestPayment",
                    "s3:GetAccessPointPolicyStatus",
                    "s3:GetObjectTagging",
                    "s3:GetBucketOwnershipControls",
                    "s3:GetMetricsConfiguration",
                    "s3:GetBucketPublicAccessBlock",
                    "s3:GetMultiRegionAccessPointPolicy",
                    "s3:GetAccessPointPolicyStatusForObjectLambda",
                    "s3:ListAccessPoints",
                    "s3:PutBucketOwnershipControls",
                    "s3:DeleteMultiRegionAccessPoint",
                    "s3:ListMultiRegionAccessPoints",
                    "s3:UpdateJobStatus",
                    "s3:GetBucketAcl",
                    "s3:ListStorageLensConfigurations",
                    "s3:GetObjectTorrent",
                    "s3:GetBucketLocation",
                    "s3:GetAccessPointPolicy",
                    "s3:ReplicateDelete"
                ],
                "Resource": "*"
            }
        ]
    }

    return my_managed_policy

def attach_user_policy(policy, policy_arn = 'arn:aws:iam::431591413306:policy/busch-teste', username="teste-s3-deny-access"):
    iam = boto3.client("iam")
    try:
        response = iam.detach_user_policy(
        UserName = username,
        PolicyArn = policy_arn
        )

        response = iam.delete_policy(
        PolicyArn = policy_arn
        )

        response = iam.create_policy(
            PolicyName = "busch-teste",
            PolicyDocument=json.dumps(policy),
            #SetAsDefault = True
        )
        
        print(response)

        response = iam.attach_user_policy(
            UserName = "teste-s3-deny-access",
            PolicyArn = policy_arn
        )
        print(response)

    except :
        response = iam.create_policy(
            PolicyName = "busch-teste",
            PolicyDocument=json.dumps(policy),
            #SetAsDefault = True
        )
        
        print(response)

        response = iam.attach_user_policy(
            UserName = "teste-s3-deny-access",
            PolicyArn = policy_arn
        )
        print(response)
    else:
        print("deu erro")

def lambda_handler(event, context):
    policy = create_iam_policy_json()
    attach_user_policy(policy=policy)
    return {
        'statusCode': 200,
        'body': json.dumps('update succeed')
    }