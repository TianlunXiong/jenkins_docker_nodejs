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
                    args '-v $HOME/dist:/var/dist'
                }
            }
            steps {
                cleanWs()
                echo 'Building..'
                sh 'git config --global url."https://ghproxy.com/https://github.com".insteadOf "https://github.com"'
                sh "git clone ${params.git_url} ."
                sh 'node -v'
                sh 'npm -v'
                sh 'npm install'
                sh 'npm run compile'
                sh 'ls -ls'
                sh 'cp -r ./dist /var/dist'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build imagename
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'docker info'
            }
        }
    }
    post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false,
                    deleteDirs: true,
                    disableDeferredWipeout: true,
                    notFailBuild: true,
                    patterns: [[pattern: '.gitignore', type: 'INCLUDE'],
                               [pattern: '.propsfile', type: 'EXCLUDE']])
        }
    }
}