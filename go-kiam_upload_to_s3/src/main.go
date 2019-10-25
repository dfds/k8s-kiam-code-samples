package main

import (
	"bytes"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
	"log"
)

func main() {
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String("eu-central-1"),
	})
	if err != nil {
		log.Fatal(err)
	}

	s3Cli := s3.New(sess)

	bucketName := "dfds.static.content"
	payloadContent := bytes.NewReader([]byte("Hi Pelle!"))

	_, err = s3Cli.CreateBucket(&s3.CreateBucketInput{
		Bucket: aws.String(bucketName),
		CreateBucketConfiguration: &s3.CreateBucketConfiguration{LocationConstraint: aws.String("eu-central-1")},
	})
	if err != nil {
		log.Fatal(err)
	}

	_, err = s3Cli.PutObject(&s3.PutObjectInput{
		Bucket: aws.String(bucketName),
		Key:    aws.String("hello"),
		Body:   aws.ReadSeekCloser(payloadContent),
		ContentType: aws.String("text/plain"),
	})
	if err != nil {
		log.Fatal(err)
	}
}