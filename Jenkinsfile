pipeline {
    agent { label 'Dev' }
    tools {
        jdk 'Java'
        maven 'Maven'
        dockerTool 'Docker'
    }
    
    stages {
        stage('Build Started') {
            steps {
                echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            }
        }
        stage('Cloning our Git') { 
            steps { 
                git 'https://github.com/epavankumar91/maven-archetype-webapp.git' 
            }
        } 
        stage('list Git') { 
            steps { 
                sh 'ls -lart' 
                sh 'echo $VER'
            }
        }           
        stage('Maven') {
            steps {
                sh 'mvn  clean package'
            }
        }
       /*stage('upload war to nexus'){
            steps{
                nexusArtifactUploader artifacts: [[artifactId: 'mvnwebapp', classifier: 'debug', file: 'target/mvnwebapp.war', type: 'war']], credentialsId: 'nexus', groupId: 'com.mvn.webapp', nexusUrl: '13.59.209.148:8081/repository/Mavenrepo/', nexusVersion: 'nexus3', protocol: 'http', repository: 'Mavenrepo', version: '1.0-SNAPSHOT'
            }
        } */
        /*stage('build docker image'){
            steps{
                sh 'sudo docker build -t pavankumargajapati/mymavenapp:1.0.0 .'
            }
        }
            stage ('push docker image'){
               steps {
                withCredentials([string(credentialsId: 'docker-hub')]) {
          
                    sh '''docker push pavankumargajapati/mymavenapp:1.0.0'''
                }
                   
                }
              
           }*/
        
         stage('docker run on slave'){
            steps{    
                script{
                    sh 'sudo systemctl start docker'
                  }
                }
              }
           
      /*    stage('docker run on master'){
               agent {
                    label "master"
                }
            steps{    
                script{
                    sh 'sudo systemctl start docker'
                  }
                }
              } */
           
           stage('docker push'){
            steps{
                script{
                  docker.withRegistry('https://registry.hub.docker.com', 'docker-hub'){
                    sh 'sudo chmod 666 /var/run/docker.sock'
                    def customImage = docker.build("pavankumargajapati/mymavenapp:1.0.1")
                     customImage.push()
                  }
                }
              }
           }
           stage('deploy to k8s') {
            steps{
                sshagent(['ssh-key']) {
               // some block
               sh "scp -o StrictHostKeyChecking=no Deployment.yaml Service.yaml ec2-user@3.145.6.144:/home/ec2-user"
               sh "ssh ec2-user@3.145.6.144 kubectl apply -f ."
                    }
                }
            }
       }
    
    }
