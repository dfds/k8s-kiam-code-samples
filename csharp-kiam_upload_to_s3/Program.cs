using System;
using System.Threading.Tasks;
using Amazon;
using Amazon.S3;
using Amazon.S3.Model;
using Amazon.SecurityToken;
using Amazon.SecurityToken.Model;

namespace csharp_kiam_upload_to_s3
{
    class Program
    {
        static void Main(string[] args)
        {
            var task = RunExample();
            task.Wait();
        }

        static async Task RunExample()
        {
            // Identity
            var client = new AmazonSecurityTokenServiceClient();
            var getCallerIdReq = new GetCallerIdentityRequest();
            var caller = await GetCallerIdentityResponseAsync(client, getCallerIdReq);
            Console.WriteLine($"Caller identity: {caller.Arn} | {caller.Account} | {caller.UserId}");
            
            // S3
            RegionEndpoint region = RegionEndpoint.EUCentral1;
            string bucketName = "dfds.static.content";
            var s3Client = new AmazonS3Client(region);

            var s3NewBucket = new PutBucketRequest
            {
                BucketName = bucketName,
                BucketRegion = S3Region.EUC1,
                CannedACL = S3CannedACL.Private
            };

            var s3BucketResponse = await s3Client.PutBucketAsync(s3NewBucket);

            var s3PutObjectRequest = new PutObjectRequest
            {
                BucketName = bucketName,
                Key = "hello",
                ContentBody = "Hi Pelle!",
                ContentType = "text/plain"
            };

            var s3PutObjectResponse = await s3Client.PutObjectAsync(s3PutObjectRequest);
        }
        
        static async Task<GetCallerIdentityResponse> GetCallerIdentityResponseAsync(AmazonSecurityTokenServiceClient client, GetCallerIdentityRequest request)
        {
            var caller = await client.GetCallerIdentityAsync(request);
            return caller;
        }
    }
}
