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
                    // Stop container running on 8682 if exists
                    bat '''
                    for /f "tokens=*" %%i in ('docker ps -q --filter "publish=8682"') do (
                        docker stop %%i
                        docker rm %%i
                    )
                    '''
                }
            }
        }

        stage('Run docker container') {
            steps {
                bat 'docker run -d -p 8682:8682 --name jenkins-app sumitdockerrepo/docker-jenkins-pipeline'
            }
        }

      stage('Push to DockerHub') {
    steps {
        bat """
        docker login -u sumitdockerrepo -p Linkun92!1015
        docker tag sumitdockerrepo/docker-jenkins-pipeline sumitdockerrepo/docker-jenkins-pipeline:latest
        docker push sumitdockerrepo/docker-jenkins-pipeline:latest
        docker logout
        """
    }
}
 
    }
}
