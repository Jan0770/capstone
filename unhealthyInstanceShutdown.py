import boto3

def lambda_handler(event, context):
    try:
        region = "us-west-2"
        ec2_client = boto3.client("ec2", region_name=region) 
        elb_client = boto3.client("elbv2")
        
        response = elb_client.describe_target_groups(
            Names=['target'])
            
        targetARN = response["TargetGroups"][0]["TargetGroupArn"]
        
        response = elb_client.describe_target_health(
            TargetGroupArn=targetARN)
        
        for target in response['TargetHealthDescriptions']:
            instance_id = target['Target']['Id']
            health_status = target['TargetHealth']['State']
            
            if health_status == "unhealthy":
                ec2_client.stop_instances(InstanceIds=[instance_id])
                print(f"Instance with ID {instance_id} was unhealthy and is shutting sdown")

            else:
                print(f"Instance with ID {instance_id} is healthy")
            
    except Exception as e:
        print(e)
            
