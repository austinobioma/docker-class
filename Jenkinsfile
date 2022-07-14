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
      stage('Mvn Build') {
            steps {
                sh 'cd webapp && mvn clean package'
                sh 'cd webapp && mvn clean install -DskipTests'  
            }
        }
        stage ('SSH To RemoteServer') {
            steps {
                  sshPublisher(publishers: 
                   [sshPublisherDesc
                      (configName: 'App_Server', 
                        transfers: 
                         [sshTransfer
                          (cleanRemote: false, 
                            excludes: '', 
                             execCommand: 
                              'docker build -t tomcat . && docker run -d -p 8080:8080 tomcat', 
                                execTimeout: 120000, 
                                 flatten: false, 
                                  makeEmptyDirs: false, 
                                   noDefaultExcludes: false, 
                                 patternSeparator: '[, ]+', 
                               remoteDirectory: '/home/ubuntu', 
                              remoteDirectorySDF: false,
                           removePrefix: '', 
                        sourceFiles: '/var/lib/jenkins/workspace/docker-build/webapp/target/webapp.war')], 
                       usePromotionTimestamp: false, 
                       useWorkspaceInPromotion: false, 
                       verbose: false
                      )
                   ]
                 )  
            }
        } 
      stage('Building Docker image') {
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
