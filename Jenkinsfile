pipeline {
    agent any

    tools {
        maven 'maven_3_9_11'
    }

    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/sumitnanda/piplineJenkins']]
                )
                bat 'mvn clean install'
            }
        }

        stage('Build docker image') {
            steps {
                bat 'docker build -t sumitdockerrepo/docker-jenkins-pipeline .'
            }
        }

        stage('Stop old container') {
            steps {
                script {
                    // Stop container running on 8282 if exists
                    bat '''
                    for /f "tokens=*" %%i in ('docker ps -q --filter "publish=8282"') do (
                        docker stop %%i
                        docker rm %%i
                    )
                    '''
                }
            }
        }

        stage('Run docker container') {
            steps {
                bat 'docker run -d -p 8282:8282 --name jenkins-app sumitdockerrepo/docker-jenkins-pipeline'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'sumitdockerrepo', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                    docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                    docker tag sumitdockerrepo/docker-jenkins-pipeline %DOCKER_USER%/docker-jenkins-pipeline:latest
                    docker push %DOCKER_USER%/docker-jenkins-pipeline:latest
                    docker logout
                    """
                }
            }
        }
    }
}
