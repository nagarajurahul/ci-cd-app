# 🚀 CI/CD Pipeline: Dockerized Node.js App to AWS EC2

## 📌 Overview
This project implements a **production-style CI/CD pipeline** using **GitHub Actions** to build and deploy a Dockerized Node.js application to an AWS EC2 instance.

It follows modern DevOps practices and is ideal for cloud professionals who want to demonstrate automated, secure, and efficient application delivery.

---

## 🛠️ Technologies Used

- **Node.js** (app backend)
- **Docker** (containerization)
- **GitHub Actions** (CI/CD automation)
- **AWS EC2** (target deployment server)
- **Shell scripting** (for remote deployment)

---

## 🔐 Secrets & Environment Variables
All secrets are stored in **GitHub Actions Secrets**:

| Name                    | Description |
|-------------------------|-------------|
| `DOCKERHUB_USERNAME`    | Docker Hub username |
| `DOCKERHUB_TOKEN`       | Docker Hub access token |
| `DOCKERHUB_IMAGE`       | Image name (e.g. `my-app`) |
| `DOCKERHUB_TAG`         | Image tag (e.g. `latest`, `github.sha`) |
| `DOCKER_CONTAINER_NAME` | Name of the container in EC2 |
| `DOCKER_CONTAINER_PORT` | Port exposed by container (e.g. `3000`) |
| `AWS_PRIVATE_KEY`       | Private SSH key for EC2 access (base64 or multiline encoded) |
| `EC2_USERNAME`          | Default EC2 user (e.g., `ec2-user`) |
| `EC2_IP_ADDRESS`        | Public IP of the EC2 instance |

---

## ⚙️ GitHub Actions Workflow: `.github/workflows/ci-cd.yml`

### 🔧 Build Job
- Checks out code
- Linting the Node.Js code using `ESLint` 
- Audit the `NPM` for dependency checks
- `Trivy` scan before push, with SARIF upload to GitHub Security tab
- `Gatekeeper` step (fail pipeline on CRITICAL/HIGH CVEs)
- Builds Docker image using `BuildKit` for multi-platform and reproducible builds
- Pushes to `Docker Hub` using dynamic tagging (`GITHUB_SHA` or manual tag)

### 🚀 Deploy Job
- Uses `needs: ci` to depend on successful build
- SSHs into `EC2` securely
- Uploads and runs `deploy.sh` script
- Pulls the image, stops old container, runs new one

---

## 🌐 Access the App
Once deployed, access your app in the browser using:
`http://<EC2_IP>:<DOCKER_CONTAINER_PORT>`
Make sure your EC2 security group allows inbound traffic on that port.

---

## ✅ Future Improvements
- Use SSM Parameter Store or Secrets Manager over env variables for docker login
- Use EC2 IAM roles + AWS SSM to avoid storing SSH keys
- Replace Docker Hub with Amazon ECR
- Migrate to ECS or Kubernetes for scalability
- Add monitoring/logging (e.g. CloudWatch, Prometheus)
- Set Up Domain + TLS
- Add HTTPS with Let's Encrypt
- Pin GitHub Actions Versions
- Pin GitHub Actions Runner to specific OS
- Add unit tests and linting to CI

---

## 👨‍💻 Author
Built by Rahul Nagaraju to showcase real-world DevOps expertise using a `home lab server + GitHub + AWS EC2`.

