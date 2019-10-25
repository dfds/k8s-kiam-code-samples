#!/bin/bash
#
# Usage
# ./pipeline.sh "ACCOUNT_ID" "tag-prefix"
#

aws_acc_id="$1"
image_tag_prefix="$2"

build_container_image() {
    echo "Building container images..."
    docker build -t kiamexample:go .
}

publish_image() {
    echo "Publishing container image"
    docker tag kiamexample:go ${aws_acc_id}.dkr.ecr.eu-central-1.amazonaws.com/${image_tag_prefix}/kiam-go:latest
    docker push ${aws_acc_id}.dkr.ecr.eu-central-1.amazonaws.com/${image_tag_prefix}/kiam-go:latest
}

build_container_image
publish_image