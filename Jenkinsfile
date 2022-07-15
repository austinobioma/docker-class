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
     stage('Copy Files to Ubuntu Home') {
            steps{
                  //sh 'cd /home/ubuntu && chmod g+x home/ubuntu'
                  sh 'cd /var/lib/jenkins/workspace/docker-build/webapp/target && cp ./webapp.war ubuntu'
                     }
         }
              
        stage ('SSH To RemoteServer') {
            steps {
                  sshPublisher(publishers: 
                               [sshPublisherDesc(configName: 'App_Server', 
                                                 transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', 
                                                                         execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, 
                                                                        patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, 
                                                                         removePrefix: '/webapp/target', sourceFiles: 'webapp/target/webapp.war\'')], 
                                                 usePromotionTimestamp: false, useWorkspaceInPromotion: false, 
                                                 verbose: true)
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
