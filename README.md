[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

## Introduction

This repository is not intended to be looked at by itself, but rather as a whole with its accompanying Playbook, *Pod access to AWS resources (Kiam)*, which can be found on the DFDS Playbooks site.

Code samples alongside accompanying Dockerfiles and Kubernetes job deployment manifests for the following languages:

* [C#](https://github.com/dfds/k8s-kiam-code-samples/tree/master/csharp-kiam_upload_to_s3)
* [Go](https://github.com/dfds/k8s-kiam-code-samples/tree/master/go-kiam_upload_to_s3)
* [Rust](https://github.com/dfds/k8s-kiam-code-samples/tree/master/rust-kiam_upload_to_s3)
* [Python](https://github.com/dfds/k8s-kiam-code-samples/tree/master/python-kiam_upload_to_s3)
* [NodeJS](https://github.com/dfds/k8s-kiam-code-samples/tree/master/nodejs-kiam_upload_to_s3)

Within each directory there is a sample in the respective language, a directory called *k8s* that contains a Kubernetes job manifest that showcases the necessary annotation for Kiam to function and a Dockerfile that will build the code sample and bundle it up, ready for usage.


## License

Distributed under the MIT License. See `LICENSE` for more information.