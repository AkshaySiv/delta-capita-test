pipeline {
    agent any
    environment {

    }

    stages {
        stage('Build with Maven') {
            steps {
                script {
                    sh 'mvn clean install'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up after build'
        }

        success {
            echo 'Build and tests completed successfully!'
        }

        failure {
            echo 'Build or tests failed!'
        }
    }
}
