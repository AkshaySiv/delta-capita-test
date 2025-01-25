pipeline {
    agent any

    environment {
        DOCKER_IMAGE_BASE = 'docker.io/akshaysiv/delta-capita-test'
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
        BRANCH_NAME = "${env.GIT_BRANCH.replaceFirst(/^origin\//, '')}"
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
                    def dockerImage = "${DOCKER_IMAGE_BASE}:v${BUILD_NUMBER}"
                    echo "Building and pushing Docker image: ${dockerImage}"
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        def app = docker.build(dockerImage)
                        app.push()
                    }
                    env.FULL_DOCKER_IMAGE = dockerImage
                }
            }
        }

        stage('Update Kubernetes YAML') {
            steps {
                script {
                    echo 'Updating Kubernetes YAML with the new Docker image'
                    sh """
                    sed -i 's|image: .*|image: ${FULL_DOCKER_IMAGE}|' Deployment/deployment.yaml
                    """
                }
            }
        }

        stage('Commit and Push Changes to Git') {
            steps {
                script {
                    echo 'Committing and pushing the updated Kubernetes YAML to Git'
                   withCredentials([usernamePassword(credentialsId: 'git-credentials-id', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        sh """
                        cat Deployment/deployment.yaml
                        git add deployment.yaml
                        git commit -m "Updated deployment image "
                        git push origin ${BRANCH_NAME}
                        """
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
