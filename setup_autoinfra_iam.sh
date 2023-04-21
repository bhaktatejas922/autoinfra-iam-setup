#!/bin/bash

# This script creates an IAM user and group for autoinfra with necessary permissions

# Set variables
USERNAME="autoinfra"      # Set the desired username for the IAM user
GROUPNAME="autoinfra-group"      # Set the desired name for the IAM group
POLICYNAME="autoinfra-policy"     # Set the desired name for the IAM policy

# Create IAM group
aws iam create-group --group-name $GROUPNAME    # Create the IAM group with the specified group name

# Create IAM user
aws iam create-user --user-name $USERNAME   # Create the IAM user with the specified username

# Add user to group
aws iam add-user-to-group --group-name $GROUPNAME --user-name $USERNAME    # Add the IAM user to the IAM group

# Create IAM policy
cat <<EOF > /tmp/$POLICYNAME.json   # Create a temporary file with the necessary policy statements
{
  "Version": "2012-10-17",   # Set the policy version to the latest
  "Statement": [
    {
      "Effect": "Allow",   # Set the effect to allow
      "Action": [
          "ec2:*",
          "autoscaling:*",
          "cloudformation:*",
          "cloudwatch:*",
          "cloudtrail:*",
          "elasticache:*",
          "elasticloadbalancing:*",
          "iam:ListInstanceProfiles",
          "iam:ListRoles",
          "rds:*",
          "s3:*",
          "sns:*",
          "sqs:*",
          "logs:*",
          "lambda:*",
          "events:*",
          "dynamodb:*",
          "ssm:*",
          "secretsmanager:*",
          "kms:*",
          "apigateway:*",
          "codebuild:*",
          "codecommit:*",
          "codedeploy:*",
          "codepipeline:*",
          "config:*",
          "directconnect:*",
          "route53:*",
          "batch:*",
          "ecs:*",
          "efs:*",
          "fsx:*",
          "kinesis:*",
          "glacier:*",
          "imagebuilder:*",
          "resource-groups:*",
          "workspaces:*",
          "datapipeline:*",
          "redshift:*",
          "cloudfront:*",
          "elasticbeanstalk:*",
          "acm:*",
          "cloud9:*",
          "opsworks:*",
          "sagemaker:*",
          "servicecatalog:*",
          "shield:*",
          "storagegateway:*",
          "trustedadvisor:*"
      ],
      "Resource": "*"   # Grant permissions to all resources
    }
  ]
}
EOF

aws iam create-policy --policy-name $POLICYNAME --policy-document file:///tmp/$POLICYNAME.json   # Create the IAM policy with the specified name and the contents of the temporary file

# Attach policy to group
aws iam attach-group-policy --group-name $GROUPNAME --policy-arn arn:aws:iam::AWS-account-ID:policy/$POLICYNAME   # Attach the IAM policy to the IAM group

# Create access key and secret key for user
aws iam create-access-key --user-name $USERNAME   # Create an access key and secret key for the IAM user
