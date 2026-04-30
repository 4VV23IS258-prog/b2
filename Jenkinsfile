pipeline {
    agent any

    environment {
        IMAGE_NAME = 'sumukha3010/sampleimage'
        CONTAINER_NAME = 'sampleimage-test'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Smoke Test') {
            steps {
                sh 'docker run --rm --name ${CONTAINER_NAME} ${IMAGE_NAME}'
            }
        }

        stage('Push Image') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_TOKEN')]) {
                    sh 'echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                    sh 'docker push ${IMAGE_NAME}'
                }
            }
        }
    }

    post {
        always {
            sh 'docker rm -f ${CONTAINER_NAME} || true'
            sh 'docker rmi -f ${IMAGE_NAME} || true'
        }
    }
}