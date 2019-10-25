#!/bin/bash
#
# Usage
# ./pipeline.sh "ACCOUNT_ID" "tag-prefix"
#

aws_acc_id="$1"
image_tag_prefix="$2"

clean_output_folder() {
    rm -Rf bin
    mkdir bin
}

restore_dependencies() {
    echo "Restoring dependencies"
    dotnet restore .
}

run_build() {
    echo "Building..."
    dotnet build -c Release .  
}

publish_binaries() {
    echo "Publishing binaries..."
    dotnet publish -c Release -o .
    dotnet publish -c Release -o output csharp-assume-role_upload_to_s3.csproj
}

build_container_image() {
    echo "Building container images..."
    docker build -t kiamexample:csharp .
}

publish_image() {
    echo "Publishing container image"
    docker tag kiamexample:csharp ${aws_acc_id}.dkr.ecr.eu-central-1.amazonaws.com/${image_tag_prefix}/kiam-csharp:latest
    docker push ${aws_acc_id}.dkr.ecr.eu-central-1.amazonaws.com/${image_tag_prefix}/kiam-csharp:latest
}

clean_output_folder
restore_dependencies
run_build
publish_binaries
build_container_image
publish_image