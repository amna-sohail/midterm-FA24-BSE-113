pipeline {
    agent any
    environment {
        IMAGE_NAME = 'midterm-fa24bse113'
        CONTAINER_NAME = 'midterm-app'
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Train, Test and Build Image') {
            steps {
                sh "docker build --build-arg GIT_COMMIT=${env.GIT_COMMIT} -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker rm -f ${CONTAINER_NAME} || true"
                sh "docker run -d --restart unless-stopped --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                sh 'docker image prune -f'
            }
        }
    }
    post {
        always {
            emailext(
                subject: "MIDTERM FA24-BSE-113 - Build #${env.BUILD_NUMBER} ${currentBuild.currentResult}",
                body: "Student Reg No: FA24-BSE-113\nStatus: ${currentBuild.currentResult}\nCommit: ${env.GIT_COMMIT}\nBuild: ${env.BUILD_URL}",
                to: 'amnsohail543@gmail.com',
                from: 'amnsohail543@gmail.com'
            )
        }
    }
}
