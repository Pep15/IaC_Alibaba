# IaC Alibaba

## Overview
This project demonstrates the use of **Infrastructure as Code (IaC)** to provision and manage cloud resources on **Alibaba Cloud**. The infrastructure setup includes a variety of essential services like **Bastion Hosts**, **NAT Gateways**, and **Load Balancers** to ensure secure and scalable cloud architecture. The entire infrastructure is automated and managed using code, enabling easy replication and scalability.

## Key Features:
- **Bastion Host Setup:** A **Bastion Server** was implemented to provide secure access to the private network. This server acts as a gateway for administrators to access cloud resources safely.
- **NAT Gateway:** A **NAT Gateway** was provisioned to allow instances in a private subnet to securely access the internet, while protecting the internal network from direct external access.
- **Load Balancer:** A **Load Balancer** was used to distribute traffic across multiple servers or services, ensuring high availability and reliability of the application.
- **Terraform (IaC):** All infrastructure components are defined and provisioned using **Terraform**, enabling a repeatable and consistent deployment of the environment.
- **Automation with GitHub Actions:** GitHub Actions was integrated to automate the deployment and updates of infrastructure, ensuring the changes are applied seamlessly and efficiently.

## Technologies Used:
- **Cloud Provider:** Alibaba Cloud
- **IaC Tool:** Terraform for defining and provisioning infrastructure
- **Cloud Components:** Bastion Host, NAT Gateway, Load Balancer
- **DevOps Tools:** GitHub Actions for CI/CD of infrastructure changes

## GitHub Workflow:
- **Automated Infrastructure Deployment:** Every change made to the IaC files triggers a GitHub Actions workflow that provisions or updates the Alibaba Cloud infrastructure automatically.
- **Testing & Validation:** The infrastructure code is validated and tested to ensure that the resources are correctly configured and meet the desired specifications.
