import boto3

bucketname = 'dfds.static.content'
region = 'eu-central-1'

try:
    s3 = boto3.resource('s3')
    client = boto3.client(
        's3',
        region_name=region,
    )

    bucket_resp = client.create_bucket(
        Bucket=bucketname, 
        CreateBucketConfiguration={
            'LocationConstraint': region
        })

    put_resp = client.put_object(
        Bucket=bucketname,
        ContentType='text/plain',
        Key='hello',
        Body=str.encode('Hi Pelle!'),
    )
except Exception:
    traceback.print_exc()