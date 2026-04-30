node {
    def imageName = 'sumukha3010/sampleimage'
    def containerName = 'sampleimage-test'

    try {
        stage('Checkout') {
            checkout scm
        }

        stage('Build Docker Image') {
            sh "docker build -t ${imageName} ."
        }

        stage('Smoke Test') {
            sh "docker run --rm --name ${containerName} ${imageName}"
        }

        if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main' || !env.BRANCH_NAME) {
            stage('Push Image') {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_TOKEN')]) {
                    sh 'echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USER" --password-stdin'
                    sh "docker push ${imageName}"
                }
            }
        }
    } finally {
        sh "docker rm -f ${containerName} || true"
        sh "docker rmi -f ${imageName} || true"
    }
}