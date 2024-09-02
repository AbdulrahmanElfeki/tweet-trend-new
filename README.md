 # CI/CD using jenkins for java web app.
This repository contains everything to set up continuous integration and continuous deployment for **tweet-trend-new** Java web application.

## Table of Contents
- Introduction
- Installation
- Usage
- Configuration
- Deployment
- Monitoring

## Introduction
CI/CD using jenkins for java web app automates the build, test, and deployment process for **tweet-trend-new** application. 

## Prerequisites
- AWS account.
- Terraform installed on your local machine.
- AWS CLI installed on your local machine.
- AWS credentials configured on your local machine.

## Installation
To get started, follow these steps:

1. Clone this repository:
`git clone https://github.com/yourusername/tweet-trend-new`
2. Deploy infrastructure using terraform.
```
$ cd tweet-trend-new/terraform/vpc
$ terraform init # download the necessary Terraform plugins
$ terraform plan #  preview the changes that Terraform plans to make to your infrastructure.
$ terraform apply --auto-approve # deploy your infrastructure.
```
3. Automate Depdendencies installation using Ansible Playbooks.
```
$ ssh -i <AWS-ACCESS-KEY> ec2-user@<ansible-PUBLIC-IP>
$ sudo yum install -y ansible
$ sudo ansible-playbook -i /opt/hosts /opt/playbook-jenkins.yml
$ sudo ansible-playbook -i /opt/hosts /opt/playbook-jenkins-slave.yml
```
4. Install the follwoing jenkins plugins:
- multibranch scan webhook trigger
- sonarqube scanner
- Artifactory
- docker pipeline

## Multibranch pipeline
1. create multi-branch pipeline.
2. scan multibranch pipeline now, branches is automatically updated.
3. configure `Scan by webhook` to automatically trigger repository updates and creates new build.

## Execute SonarCube analysis
1. Configure sonarqube server on jenkins with `Name`, `Server URL`, `Server authentication token`.
2. Configure sonarqube scanner on jenkins with `Name`, `Version`.
3. Add Quality gates on Sonarcloud.

## publishing a Docker image on Jfrog Artifactory.
1. Generate an access token with a username.
2. Add username and Password under Jenkins Credentials.
3. Create Maven repository on Jfrog.
4. Create a docker repository in the Jfrog
5. Testing Docker image by creating container out of it.
```
$ ssh -i <AWS-ACCESS-KEY> ec2-user@<maven-slave-PUBLIC-IP>
$ docker run -d --name tweet-trend-new -p 8000:8000 <REPOSITORY>:<VERSION> 
```

## Deploying the Kubernetes objects using Helm
1. Configure awscli to connect with aws account.
2. Download Kubernetes credentials and cluster configuration (.kube/config file) from the cluster
```
$ aws eks update-kubeconfig --region us-east-1 --name valazy-eks-01
```
3. Install helm
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
4. create a helm chart template
```
$ helm create tweet-v1
```
5. Replace the template directory with the manifest files and package it
```
$ helm package tweet-v1
```

## Monitoring
1. Deploy Prometheus
```
$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
$ helm install prometheus prometheus-community/prometheus
$ helm repo update
$ helm install prometheus prometheus-community/prometheus
$ kubectl expose service prometheus-server — type=NodePort — target-port=9090 — name=prometheus-server-ext
```
2. Deploy Grafana
```
$ helm repo add grafana https://grafana.github.io/helm-charts
$ helm install grafana grafana/grafana
$ helm repo update
$ kubectl expose service grafana — type=NodePort — target-port=3000 — name=grafana-ext
$ kubectl get secret — namespace default grafana -o yaml
$ echo “password_value” | openssl base64 -d ; echo
$ echo “password_value” | openssl base64 -d ; echo
```
3. Import **Kubernetes Dashboard** Grafana template to monitor pod cpu, memory, I/O, RX/TX and cluster cpu, memory request/limit/real usage, RX/TX, Disk I/O.
```
https://grafana.com/grafana/dashboards/18283-kubernetes-dashboard/
```
