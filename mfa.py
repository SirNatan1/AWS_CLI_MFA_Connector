import boto
import os
from boto.s3.connection import S3Connection
from boto.sts import STSConnection

mfa_TOTP = input("Enter the MFA code: ")

sts_connection = STSConnection()

tempCredentials = sts_connection.get_session_token(
    duration=86400,
    mfa_serial_number="arn:aws:iam::<accountID>:mfa/<mfa-name>",
    mfa_token=mfa_TOTP
)

print("export AWS_ACCESS_KEY_ID=" + tempCredentials.access_key)
print("export AWS_SECRET_ACCESS_KEY=" + tempCredentials.secret_key)
print("export AWS_SESSION_TOKEN=" + tempCredentials.session_token)