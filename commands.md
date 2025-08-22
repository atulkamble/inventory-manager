```

// manual run 

EC2 | Amazon linux | t3.medium | key.pem 
try ssh 
SG: 5000 (Inbound)

sudo yum update -y 
sudo yum install git python -y 
sudo yum install pip 
pip install flask
git clone https://github.com/atulkamble/inventory-manager.git
cd /inventory-manager
cd app
python3 main.py

// go out of running code using Cntrl+C


// docker phase 

sudo yum install docker -y 
sudo systemctl start docker 
sudo systemctl enable docker 
sudo docker login 

sudo docker build -t username/inventory-management .
sudo docker images 
sudo docker push username/inventory-management

sudo docker run -d -p 5000:5000 username/inventory-management

sudo docker logs log-id 
sudo docker container ls 
sudo docker container stop container-id 

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

docker compose version

sudo docker compose up --build

http://instance-ip:5000

cd k8s 

// on minikube 

// docker desktop running in background 

minikube start

kubetcl apply -f deployment.yaml 
kubectl apply -f service.yaml 

kubectl get deployments 
kubectl get pods
kubectl get services 

minikube dashboard 

http://127.0.0.1:5000/

// on eks 

eksctl create cluster \
--name mycluster \
--region us-east-1 \
--nodegroup-name mynodes \
--node-type t3.micro \
--nodes 2 \
--nodes-min 2 \
--nodes-max 2 \
--managed

eksctl create cluster --name mycluster --region us-east-1 --nodegroup-name mynodes --node-type t3.micro --nodes 2 --nodes-min 2 --nodes-max 2 --managed

stop >> Setting >> Change Instance type >> large

EC2 | amazon linux | large instance type 
SG: 8080 

sudo yum update -y 
sudo yum install git -y 
git clone https://github.com/atulkamble/inventory-manager.git
cd inventory-manager
chmod +x jenkins-install.sh 
./jenkins-install.sh 

copy password from shell path & paste in web browser - http://instance-ip:8080

git config --global user.name "Atul Kamble"
git config --global user.email "atul_kamble@hotmail.com"
git config --list 
sudo systemctl status docker
java --version 
mvn -v 

// set username and password - admin, admin 

Settings >> plugins >> docker, docker pipeline, Blue Ocean

tools Setting >> git, myMaven, myDocker | Select Install automatically 

sudo systemctl restart jenkins 

New Item >> create pipeline >> paste following script >> build 

pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
                sh 'git --version'
                sh 'docker --version'
            }
        }
    }
}

IAM >> user >> admin group >> policy (FullAdminAccess)

create access key and add it to ec2 

aws configure

sudo usermod -aG docker ec2-user

>> ECR

Repo Name: atulkamble/inventory-manager

URI >> public.ecr.aws/x4u2n2b1

docker build -t public.ecr.aws/x4u2n2b1/atulkamble/inventory-manager:latest .

docker push public.ecr.aws/x4u2n2b1/atulkamble/inventory-manager:latest 

```
// Jenkins Phase 

1. Install and configure Jenkins 

git clone https://github.com/atulkamble/inventory-manager.git
cd inventory-manager
chmod +x jenkins-install.sh
./jenkins-install.sh

http://instance-ip:8080

admin,admin

Plugins - docker, docker pipeline, Blue Ocean
Tools - myDocker, myMaven 

2. Configure Docker and Github credentials in setting.
example:

dockerhub-creds

3. Create pipeline - inventory-manager 
4. git credentials configure - from scm 
url - https://github.com/atulkamble/inventory-manager.git
branch - main
5. build pipeline 
6. console output 

 stage('Deploy to EKS') {
      steps {
        // Option A: Update image directly on the Deployment (recommended; no file edits)
        sh """
          kubectl set image deployment/inventory-manager \
            inventory-manager=${FULL_IMAGE} \
            --record
          kubectl rollout status deployment/inventory-manager --timeout=120s
        """

        // Option B (alternative): apply manifests from repo (uncomment to use)
        // sh '''
        //   # If you prefer applying manifests, make sure the image line is dynamic
        //   # sed -i works on GNU; for macOS agents use: sed -i '' ...
        //   sed -i "s@^\\s*image:.*@    image: ${FULL_IMAGE}@g" k8s/deployment.yaml
        //   kubectl apply -f k8s/
        //   kubectl rollout status deployment/inventory-manager --timeout=120s
        // '''
      }
    }
