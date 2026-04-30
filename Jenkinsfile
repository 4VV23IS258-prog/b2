node {
    def imageName = 'sumukha3010/program2'
    def containerName = 'program2-test'

    try {
        stage('Checkout') {
            checkout scm
        }

        stage('Build Docker Image') {
            powershell "docker build -t ${imageName} ."
        }

        stage('Smoke Test') {
            powershell "docker run --rm --name ${containerName} ${imageName}"
        }

        if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main' || !env.BRANCH_NAME) {
            stage('Push Image') {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_TOKEN')]) {
                    powershell '$env:DOCKERHUB_TOKEN | docker login -u $env:DOCKERHUB_USER --password-stdin'
                    powershell "docker push ${imageName}"
                }
            }
        }
    } finally {
        powershell "try { docker rm -f ${containerName} | Out-Null } catch { }"
        powershell "try { docker rmi -f ${imageName} | Out-Null } catch { }"
    }
}