# **Code to get temporary AWS credentials using MFA**
This Python script allows you to get temporary AWS credentials using Multi-Factor Authentication (MFA).

## **Prerequisites**
Before using this script, make sure you have the following:
- An AWS account
- AWS credentials with permissions to perform the get_session_token operation
- An MFA device assigned to your IAM user
- The ARN of the MFA device
- pip install boto (if it dosent exist)

## **Usage**
1. Save the code as get_aws_temp_credentials.py.
2. Open the command line interface.
3. Navigate to the directory containing get_aws_temp_credentials.py.
4. Run the command python get_aws_temp_credentials.py.
5. Enter the MFA code when prompted.
6. The script will output the temporary AWS credentials that you can use to access AWS resources.
7. Copy and paste the printed values (They are exported as an ENV var)

Note: Make sure to replace <accountID> and <mfa-name> with your actual account ID and MFA device name, 
respectively, in the mfa_serial_number parameter.
