pipeline {
    agent any
    
    environment {
        registryCredential = 'c2980fa3-ab4d-4879-ab51-7ffeae140a2a'
    }
    
    stages {
            stage('拉取代码') {
                steps {
                    cleanWs()
                    withDockerContainer(image: "node:latest") {
                        sh 'git config --global url."https://ghproxy.com/https://github.com".insteadOf "https://github.com"'
                        sh "git clone ${params.git_url} ."
                    }
                }
            }
            stage('构建镜像') {
                steps {
                    sh 'ls -ls'

                    script {
                        def commitTag = sh(  returnStdout: true, script: 'git log --oneline -1 | awk \'{print \$1}\'')
                        def dockerImage = docker.build("tainlx/test:${commitTag}")
                        docker.withRegistry('', registryCredential) {
                            dockerImage.push()
                        }
                    }
                    sh 'docker images'
                    sh 'docker image rm -f tainlx/test'
                    sh 'docker images'
                }
            }
    }
}

node {
    def remote = [:]
    remote.name = 'test'
    remote.host = '192.168.1.17'
    remote.user = 'root'
    remote.password = '1313567'
    remote.allowAnyHosts = true
    stage('部署项目') {
        sshCommand remote: remote, command: "touch miu.txt"
    }
}