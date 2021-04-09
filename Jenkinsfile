pipeline {
    environment {
        imagename = "tainlx/test_1"
        registryCredential = 'yenigul-dockerhub'
        dockerImage = ''
    }
    agent any

    stages {
        stage('Clean') {
            steps {
                cleanWs()
                echo '清理完成'
            }
        }
        stage('Build image') {
            agent {
                docker {
                    image 'node:14'
                    args '-v $HOME/app:/var/app -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                cleanWs()
                echo 'Building..'
                sh 'git config --global url."https://ghproxy.com/https://github.com".insteadOf "https://github.com"'
                sh "git clone ${params.git_url} app"
                sh 'node -v'
                sh 'npm -v'
                sh 'docker version'
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
                sh 'cd $HOME && ls -ls'
            }
        }
    }
}