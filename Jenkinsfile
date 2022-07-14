pipeline {
    agent any
    environment {
       imagename = "austinobioma/tomcat"
       registryCredential = 'DockerHub'
       dockerImage = ''
           }
    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/austinobioma/docker-class.git'
            }
        }
      stage('Build') {
            steps {
               sh 'cd webapp && mvn clean  package'
            }
        }
      stage('Test') {
            steps {
                sh 'cd webapp && mvn clean install -DskipTests'
            }
        }
      stage('Building image') {
           steps{
                script {
                     dockerImage = docker.build imagename
                       }
                   }
          }
     stage('Deploy Image') {
           steps{
               script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push("$BUILD_NUMBER")
                    dockerImage.push('latest')
                                              }
                                    }
                             }
                  }
     stage('Remove Unused docker image') {
          steps{
              sh "docker rmi $imagename:$BUILD_NUMBER"
              sh "docker rmi $imagename:latest"
                        }
               }  
       }
  }
