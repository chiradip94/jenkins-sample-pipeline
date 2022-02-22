# Pipeline for building and deploying sample application

## Folder structure
```
 |___ tools
 |
 |
 |___ helm
        |__ templates
```

## Prerequisites
- Needs to create a credential with id "dockerhub" containing username and password for dockerhub repo.

## Features
- Builds Docker image and pushes it to dockerhub.
- Deploys it in kubernetes cluster.

## Usage
To deploy the application the following steps are to be performed.
1. Build a docker image using the Dockerfile provided in tools folder which has helm and kubectl baked in. This will be used for PodTemplate in Jenkins. Thas has already been created.
2. Create a pipeline using the provided Jenkinsfile
3. Trigger it manually. The first trigger should be made to create the parameters which can then be used using "build with parameters"

### Inputs
1. repoUrl    - The https url for repository which has the Dockerfile and helm chart.
2. repoBranch - Branch for the repository.