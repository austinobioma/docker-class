pipeline {
    agent any

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
                sh 'cd webapp && mvn test'
            }
        }
    }
}
