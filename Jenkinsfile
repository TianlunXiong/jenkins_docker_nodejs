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
                    args '-v $HOME/app:/var/app'
                }
            }
            steps {
                cleanWs()
                echo 'Building..'
                sh 'git config --global url."https://ghproxy.com/https://github.com".insteadOf "https://github.com"'
                sh "git clone ${params.git_url} app"
                sh 'node -v'
                sh 'npm -v'
                sh 'cd ./app && npm install && npm run compile'
                sh 'cp -r ./app /var/app'
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
                sh 'ls -ls'
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