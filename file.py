import boto3

TARGET_REGIONS = ["us-east-1", "ap-southeast-2"]

def lambda_handler(event, context):

    ami_id = event['detail']['responseElements']['imageId']
    ami_name = event['detail']['requestParameters']['name']
    source_region = event['region']

    if "golden" not in ami_name:
        return "Not target AMI"

    for region in TARGET_REGIONS:
        ec2 = boto3.client('ec2', region_name=region)
        ec2.copy_image(
            SourceRegion=source_region,
            SourceImageId=ami_id,
            Name=f"{ami_name}-copy-{region}"
        )

    return "Copy Started"