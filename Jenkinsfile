pipeline {
    agent any
    options {
        timeout(time: 15, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
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
                sh "docker build --build-arg GIT_COMMIT=${env.GIT_COMMIT} -t ${IMAGE_NAME}:latest ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker rm -f ${CONTAINER_NAME} || true"
                sh "docker run -d --restart unless-stopped --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}:latest"
                sh 'docker image prune -f'
            }
        }
        stage('Verify') {
            steps {
                sh 'for i in 1 2 3 4 5 6 7 8 9 10; do curl -sf http://localhost:8000/metrics && exit 0; sleep 3; done; exit 1'
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
