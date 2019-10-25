var AWS = require('aws-sdk');

const BUCKETNAME = "dfds.static.content";
const REGION = "eu-central-1";

AWS.config.getCredentials( (err) => {
    if (err) {
        console.log(err.stack);
    } else {
        console.log("Credentials gathered");
        console.log(AWS.config.credentials.accessKeyId);
        console.log(AWS.config.credentials.secretAccessKey);
        AWS.config.region = REGION;
        var s3 = new AWS.S3(AWS.config);

        s3.createBucket({
            Bucket: BUCKETNAME,
            CreateBucketConfiguration: {
                LocationConstraint: REGION
            }
        }, (err, data) => {
            if (err) {
                console.log(err);
            } else {
                console.log("Created Bucket.")
                s3.putObject({
                    Bucket: BUCKETNAME,
                    Key: "hello",
                    ContentType: "text/plain",
                    Body: "Hi Pelle!"
                }, (err, data) => {
                    if (err) {
                        console.log(err.stack);
                    } else {
                        console.log("Added object to Bucket.")
                    }
                });
            }
        });
    }
});