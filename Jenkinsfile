pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/semihgume/hello-world-webapp.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Create Image') {
            steps {
                sh 'docker build -t hello-world-app-v1 .'
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dhpass', variable: 'dhpass')]) {
                    sh 'docker login -u devopsuserx -p ${dhpass}'
                }
                sh 'docker tag hello-world-app-v1 devopsuserx/hello-world-app-v1'
                sh 'docker push devopsuserx/hello-world-app-v1'
            }
        }
        stage('Pull Docker Image and Run') {
            steps{
                sshagent(['ssh-agent']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no debian-2@192.168.88.140 'docker pull devopsuserx/hello-world-app-v1'
                        ssh -o StrictHostKeyChecking=no debian-2@192.168.88.140 'docker run -d -p 8080:8080 devopsuserx/hello-world-app-v1'
                    '''
                }
            }
        }
    }
}
