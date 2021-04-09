pipeline {
    agent { dockerfile true }

    stages {
        stage('Clone') {
            steps {
                cleanWs()
                sh "git clone ${params.git_url} app"
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh "cd ./app"
                sh 'node -v'
                sh 'npm -v'
                sh 'dirs'
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