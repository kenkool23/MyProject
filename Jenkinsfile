pipeline {
    agent any
    
    environment {
        GIT_URL = 'https://github.com/kenkool23/MyProject.git'
        TOMCAT_URL    = 'http://54.91.213.14:8080/'
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git "${GIT_URL}"
            }
        }
        stage("SonarQube analysis") {
            steps {
              withSonarQubeEnv('sonar') {
                sh 'mvn -f SampleWebApp/pom.xml clean package sonar:sonar'
              }
            }
          }
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
        stage('Build with Maven') {
            steps {
                sh 'cd SampleWebApp && mvn clean package'
            }
        }
    
        stage('Deploy to Tomcat') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat-id', 
                path: '', 
                url: "${TOMCAT_URL}")], 
                contextPath: 'myapp',
                war: '**/*.war'
            }
        }
    }
}
