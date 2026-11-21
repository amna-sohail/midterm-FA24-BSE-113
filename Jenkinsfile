pipeline {
    agent any
    environment {
        IMAGE_NAME = "midterm-fa24bse113"
        CONTAINER_NAME = "midterm-app"
    }
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Train & Test') {
            steps {
                sh 'python3 -m venv venv'
                sh '. venv/bin/activate && pip install -r requirements.txt'
                sh '. venv/bin/activate && python train.py'
                sh '. venv/bin/activate && pytest -q'
            }
        }
        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker rm -f ${CONTAINER_NAME} || true"
                sh "docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
        }
    }
    post {
        always {
            emailext (
                subject: "MIDTERM-FA24-BSE-113 Build ${env.BUILD_NUMBER} - ${currentBuild.currentResult}",
                body: "Student Reg No: FA24-BSE-113\nBuild status: ${currentBuild.currentResult}\nGit SHA: ${env.GIT_COMMIT}",
                to: 'qasimalik@gmail.com',
                from: '<your-sender-email>'
            )
        }
    }
}
