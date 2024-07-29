def registry = "https://abdulrahmanelfeki.jfrog.io/"
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
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"601e4cb3-6dcc-4b2a-8175-74c666619afe"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/(*)",
                              "target": "sunny-libs-release-local/{1}",
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
    } 
}

