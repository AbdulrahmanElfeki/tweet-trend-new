def registry = "https://abdulrahmanelfeki.jfrog.io/"
def imageName = "https://abdulrahmanelfeki.jfrog.io/tweet-docker-local/tweet"
def version = "2.1.3"
pipeline {
    agent { label 'maven' }

    environment {
        PATH = "/opt/apache-maven-3.9.8/bin:$PATH"
    }

    stages {
        stage('build') {
            steps {
                sh "mvn clean deploy -Dmaven.test.skip=true"
            }
        }
        stage('test') {
            steps {
                sh "mvn surefire-report:report"
            }
        }
        /*
        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonarqube-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        */
        stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"b0158021-18c0-41d6-afba-b56634b0b2fc"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "cicd-libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.sha1", "*.md5"]
                            }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
                    }
                }   
        }
        stage("Docker build"){
            steps {
            script {
                    echo '<--------------- Docker Build Started --------------->'
                    app = docker.build(imageName+":"+version)
                    echo '<--------------- Docker Build Ended --------------->'  
                    }
        stage("Docker build"){
            steps {
            script {
                    echo '<--------------- Docker Publish Started --------------->'
                    docker.withRegistry(registry,"b0158021-18c0-41d6-afba-b56634b0b2fc")
                    echo '<--------------- Docker Publish Ended --------------->'  
                    }       
    } 
}

