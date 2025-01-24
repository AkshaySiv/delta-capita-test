pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'docker.io/akshaysiv/delta-capita-test:v1'
    }

    stages {
        stage('Build with Maven') {
            steps {
                script {
                    echo 'Building application using Maven...'
                    sh 'mvn clean package -q'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo 'Running unit tests...'
                    sh 'mvn test -q'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh "docker build -t ${DOCKER_IMAGE} -f Dockerfile ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to registry...'
                    sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up after build...'
            sh 'docker system prune -f'
        }

        success {
            echo 'Completed successfully!'
        }

        failure {
            echo 'Deployment failed!'
        }
    }
}
