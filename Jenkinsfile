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

        stage('Build and Push Docker Image') {
            steps {
                script {
                    echo 'Building and pushing Docker image using Docker plugin...'
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        def app = docker.build("${DOCKER_IMAGE}")
                        app.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up after build...'
        }

        success {
            echo 'Build, test, and deployment completed successfully!'
        }

        failure {
            echo 'Build, test, or deployment failed!'
        }
    }
}
