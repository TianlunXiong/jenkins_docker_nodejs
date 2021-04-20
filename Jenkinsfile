pipeline {
    agent any

    options{  timestamps () }

    parameters {
        string(name: 'git', defaultValue: '', description: '项目git地址')
        string(name: 'email', defaultValue: '', description: '邮件通知地址')
    }
    
    environment {
        registryCredential = 'c2980fa3-ab4d-4879-ab51-7ffeae140a2a'
    }
    
    stages {
            stage('拉取代码') {
                when { expression { return params.git != '' } }
                steps {
                    deleteDir()
                    echo '已清理工作目录'
                    withDockerContainer(image: "node:latest") {
                        sh "git config --global url.\"https://ghproxy.com/https://github.com\".insteadOf \"https://github.com\""
                        sh "git config --global --list"
                        sh "git clone ${params.git_url} ."
                    }
                }
            }
            stage('构建镜像') {
                when { expression { return params.git != '' } }
                steps {
                    sh 'ls -ls'
                    script {
                        def commitTag = sh(returnStdout: true, script: 'git log --oneline -1 | awk \'{printf \$1}\'')
                        def tag = "tainlx/test:${commitTag}"
                        def dockerImage = docker.build(tag)
                        docker.withRegistry('', registryCredential) {
                            dockerImage.push()
                        }
                        sh 'docker images'
                        sh "docker image rm -f ${tag}"
                        sh 'docker images'
                        sh 'echo 已删除本地镜像'
                    }
                }
            }
    }
    post {
        always {
            deleteDir()
            echo '已清理工作目录'
        }
        success {
            script {
                if (params.email != '') {
                    emailext (
                        subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                        body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                            <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
                        to: "jellyxiong@outlook.com",
                        from: "418219627@qq.com"
                    )
                }
            }
        }
        failure {
            script {
                if (params.email != '') {
                    emailext (
                        subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                        body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                            <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
                        to: "jellyxiong@outlook.com",
                        from: "418219627@qq.com"
                    )
                }
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
