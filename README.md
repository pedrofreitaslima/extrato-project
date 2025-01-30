# Extrato Lancamento Project

## Table of Content
+ [Description](#description)
+ [Prerequisites](#prerequisites)
+ [Resources](#resources)
+ [Git Workflow](#git-workflow)
+ [Solution Architect](#solution-architect)
+ [Authors](#authors)

### <a id="description">Description</a>
This project was created to attend the **dry-run AWS** for **Extrato project**, which approach data events registered for customers then produce event saved in **Apache Kafka**, when **Apache Kafka** received this event it should trigger an **ETL** using **AWS Glue** thus doing data ingestion, in the end this data events should be available in some **OpenSearch** for future searching. 

### <a id="prerequisites">Prerequisites</a>
- **Git** - version ~> 2.47.0
- **GitHub** - any version, this use to save repository 
- **Terraform** - version 1.3.0
- **hashicorp/aws** - version ~> 5.0.0
- **AWS** - any account what you can connect and create all resources describe bellow
- **aws-cli** - version ~> 2.22.3, used locally to connect in AWS
- **Scala** - version ~> 3.6.2
- **Java** - version ~> 11
- **Python** - version ~> 3.10

### <a id="resources">Resources</a>
- AWS IAM Role
- AWS IAM Policy
- AWS VPC
- AWS Subnets
- AWS Internet Gateway
- AWS VPC Route
- AWS VPC Route Table
- AWS Security Groups
- AWS EC2
- AWS Lambda
- AWS S3
- AWS MSK Serverless Cluster
- AWS Glue Schema Registry
- AWS Glue Catalog
- AWS Glue Connection
- AWS Glue Job
- AWS Athena

### <a id="git-workflow">Git Workflow</a>
Bellow show the image with draws of example to flow for this repository.

#### Branches:
- **Production**        - [main]
- **Development**       - [development]
- **Feature**           - [feature/]
- **Release**           - [release/]
- **Bugfix**            - [release/]
- **Hotfix**            - [hotfix/]
- **Support**           - [support/]
- **Version Tags**      - []

According to the documentation in this link: https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow

![Git Workflow](/docs/images/git-workflow.svg)

### <a id="solution-architect">Solution Architect</a>
![Solution Architect ](/docs/images/macro-solution-architect.png)

### <a id="authors">Authors</a>
&copy; **BRQ** </br>
&copy; **AWS** </br>
&copy; **pedrofreitaslima** </br>
&copy; **Itau**

