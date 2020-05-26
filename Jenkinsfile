#! groovy
// Run docker build

properties([disableConcurrentBuils])

pipeline {
    agent {
        label 'master'
        }
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()       
    }
    stages {
        stage('docker build') {
            steps {
                echo " ===============start building image==============="
                sh './deploy.sh'
            }
        }
    }
}
