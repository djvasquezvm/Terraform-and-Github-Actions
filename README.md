# Here you can see a deploy to aws using terraform and github actions

This is going to be created:
- S3 bucket: to store terraform.tfstate
- DynamoDB: to lock terraform.tfstate
- ec2: to test using github actions
- segurity group: to test using github actions
- key pair: to test using github actions
