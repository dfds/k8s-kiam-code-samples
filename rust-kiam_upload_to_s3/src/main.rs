extern crate rusoto_core;
extern crate rusoto_s3;

use rusoto_s3::{S3, CreateBucketRequest, PutObjectRequest, CreateBucketConfiguration};
use rusoto_core::ByteStream;
use std::future::Future;

const BUCKETNAME : &str = "dfds.static.content";
const REGION : &str = "eu-central-1";

fn main() {
    let s3_client = rusoto_s3::S3Client::new(rusoto_core::region::Region::EuCentral1);

    let mut bucket_req = CreateBucketRequest::default();
    let mut bucket_config = CreateBucketConfiguration::default();
    bucket_config.location_constraint = Some(REGION.to_owned());
    bucket_req.bucket = BUCKETNAME.to_owned();
    bucket_req.create_bucket_configuration = Some(bucket_config);

    let payload : Vec<u8> = "Hi Pelle!".as_bytes().iter().cloned().collect();
    let mut object_req = PutObjectRequest::default();
    object_req.bucket = BUCKETNAME.to_owned();
    object_req.key = "hello".to_owned();
    object_req.content_type = Some("text/plain".to_owned());
    object_req.body = Some(payload.into());

    s3_client.create_bucket(bucket_req).sync().expect("Couldn't create bucket");
    s3_client.put_object(object_req).sync().expect("Couldn't put object");
}