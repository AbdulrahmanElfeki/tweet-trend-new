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
        /*
        stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-cred"
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
        /*
        /
        stage("Docker build"){
        steps {
            script {
                    echo '<--------------- Docker Build Started --------------->'
                    app = docker.build(imageName+":"+version)
                    echo '<--------------- Docker Build Ended --------------->'  
                    }
                }
        }
        */
        /*
        stage("Docker publish"){
            steps {
            script {
                    echo '<--------------- Docker Publish Started --------------->'
                    docker.withRegistry(registry,"jfrog-cred"){
                        app.push()
                    }
                    echo '<--------------- Docker Publish Ended --------------->'  
                    }       
                }
            }
        */
        /*
        stage("Deploy"){
            steps{
                script{
                    sh 'helm install tweet-v1 tweet-0.1.0.tgz '
                }
            }
        }
        */
    } 
}

