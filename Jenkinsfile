pipeline {
    agent { dockerfile true }

    stages {
        stage('Clone') {
            steps {
                sh "git clone ${params.git_url}"
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'node -v'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}