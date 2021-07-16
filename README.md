# application


This is simple application that calculate factorial of positive number.

what this repository for and how it works.

This repository helps you to install your application in existing eks cluster and
create service for you to host this application in the internet through service and LB.

# Application

Application itself now is just one index.html with calculation of factorial with cache.

Directory application has application itself and dockerfile for image we generate every commit.

# CI/CD

CI/CD consists of 2 parts:

1. Generate docker image for every commit in main and upload it to ECR with latest tag
2. Run terraform template (deployment set with 2 replicas and service with LB) and apply it to EKS.

Name for web app is changed every commit that's why we guarantee that we update our application every commit.
But of course we dont affect LB in this case if we don't do changes there.


