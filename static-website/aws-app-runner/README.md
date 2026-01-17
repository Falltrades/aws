# AWS-App-Runner

This is an example repository containing Terraform code. It contains the code to deploy a static web page using AWS App Runner.

## Tree
```
.
├── docker
│   ├── Dockerfile
│   └── index.html
├── misc
│   └── architecture.dot.png   # Generated with https://github.com/patrickchugh/terravision
├── README.md
└── terraform
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    └── variables.tf
```

## Architecture diagram

<img src="./misc/architecture.dot.png">

## Helpful informations

Note that AWS App Runner does not support pulling image from other source than ECR. That's why we are using GitHub repository url. Even if the GitHub repository is public, you will need to complete pending handshake manually. 

<img src="./misc/architecture.dot.png">
