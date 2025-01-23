pipeline {
    agent any

    stages {
        stage('Build with Maven') {
            steps {
                script {
                    sh 'mvn clean install -q'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh 'mvn test -q'
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
