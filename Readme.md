TERRAFORM 
-----------
Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp. 
It allows you to define and provision infrastructure using a high-level configuration language called
 **HashiCorp Configuration Language (HCL) or JSON**. 
 Terraform supports a wide range of cloud providers, including AWS, Azure, Google Cloud, and many others, making it a versatile tool for managing infrastructure across multiple platforms.
## Key Features
* **Infrastructure as Code**: Define your infrastructure in configuration files that can be versioned and shared.
* **Multi-Cloud Support**: Manage resources across different cloud providers and on-premises environments.
* **Resource Management**: Automate the creation, update, and deletion of infrastructure resources.
## Basic Workflow
* Write: Define your infrastructure in configuration files.
* Plan: Generate an execution plan to preview changes.
* Apply: Apply the changes to your infrastructure.
* Destroy: Remove infrastructure resources when they are no longer needed.
## Prerequiscites
* terraform 
* aws cli
* azure cli
## Working with terraform

To initialize the providers and backend
 ```bash
   terraform init
   ```
To validate
 ```bash
   terraform validate
   ```
To apply Infrastructure
 ```bash
   terraform apply
   ```
To destroy,run this
 ```bash
   terraform destroy
   ```
## Ntier_project
This folder helps in creating resources with the help of **Resources block**

Resources -> These are the specific provider services 

We use those resources to create our own infrastructure when ever we want without manual interaction

In this, I created resources like
   * Vpc
   * security-group
   * ec2-instance

## using-modules
This folder helps in creating resources with the help of **modules block**

Modules -> These are nothing but a specific templates which were written by providers/organiztions

We use those modules to create our own infrastructure

These helps in reducing number of code lines

In this, I created resources like
   * Vpc
   * security-group
   * ec2-instance 


## sample.tf
we need to create a file with extension as '.tf'

In this **sample.tf**,
  used aws as provider 
  
  I had created a vpc with name as 'base'
