# DevSecOps coding assessment

## Dear Candidate
Welcome to our take-home coding assessment. We trust you'll find this assessment both challenging and rewarding, and we look forward to the opportunity to discuss your accomplishments further in the next stage.

## Your Challenge
Develop an Infrastructure as Code solution for deploying a scalable web application stack consisting of containerized components:

1. **_Web Server:_** Containerized Any HTTP Server (eg. node.js)
2. **_Database Server:_** Containerized MySQL or any NoSQL
3. **_Application Server:_** Containerized lightweight Python or Node.js application

## Requirements:
- Use a version control system (e.g., Git) to manage your codebase.
- Utilize a container orchestration tool (e.g., Kubernetes, Docker Swarm) for managing the containerized infrastructure.
- Implement infrastructure provisioning using a cloud provider of your choice (e.g., AWS, Azure, GCP) or a local virtualization tool (e.g., Minikube, Docker Desktop).
- Ensure the solution is modular, scalable, and easily configurable for different levels of load and traffic.
- Include appropriate security measures in your containerized infrastructure setup, focusing on DevSecOps principles.
- Implement auto-scaling capabilities for handling increased demand on the web application.
- Use best practices for containerization, including Dockerfile optimization and container image management.
- Ensure proper networking setup for communication between containers and external traffic.
- Use Infrastructure as Code principles for managing container configurations and deployments.

## Secrets Management:
- **Organize secrets securely:** Implement a secure method for managing and storing secrets (such as API keys, database credentials) within the repository. Avoid hardcoding sensitive information directly into configuration files or Dockerfiles.
- **Use a secrets management tool:** Utilize a dedicated secrets management tool or service (e.g., AWS Secrets Manager, HashiCorp Vault) to securely store and access secrets. Ensure that access to the secrets is restricted and auditable.
- **Encrypt sensitive data:** Encrypt sensitive data at rest and in transit to ensure confidentiality. Use encryption mechanisms provided by the secrets management tool or implement encryption within the application code.
- **Document secrets handling:** Provide clear documentation on how to access and use secrets securely. Document the process for updating or rotating secrets to maintain security.

## Deliverables:
- Infrastructure as Code scripts or configuration files for provisioning the containerized web application stack.
- README.md file providing instructions on how to:
    1. Set up and configure the containerized infrastructure.
    2. Deploy the containerized web application stack.
    3. Securely manage and access secrets within the repository.
    4. Any additional considerations or notes related to containerization, security, and scalability.

## Bonus (Optional):
- Implement a CI/CD pipeline for automated testing, building, and deploying the containerized web application stack.
- Integrate logging and monitoring solutions specifically tailored for containerized environments.
- Utilize container registry services for managing container images.
- Implement blue-green or canary deployment strategies for rolling out updates.

## Evaluation Criteria:
- Adherence to requirements and best practices for containerization and Infrastructure as Code.
- Clarity, readability, and organization of code.
- Robustness and scalability of the containerized infrastructure setup.
- Security measures implemented for containerized environments.
- Documentation quality.
- Use of automation and tooling for container management and scaling.

## Interview process
- You have 4 days to complete the assessment. We know everyone is busy, so if you need one more day let us know.
- During the interview you need to explain and demonstrate the code via the feature requirements