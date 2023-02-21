node{
    def buildNumber = BUILD_NUMBER
     
    stage('SCM Checkout'){
        git url: 'https://github.com/rammarx11/java-web-app-docker.git',branch: 'master'
    }
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
    } 
    stage("Build Dokcer Image") {
        sh "docker build -t rammarx/java-web-app:${buildNumber} ."
    }
    stage("Docker login and Push"){
        withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
            sh "docker login -u rammarx -p ${docker}" 
            
        }
        sh "docker push rammarx/java-web-app:${buildNumber}"
    }
    stage("Deploy to dockercontinor in docker deployer"){
        sshagent(['ubuntu']) {
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.134 docker rm -f javawebcontainer || true"
            sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.134 docker run -d -p 8080:8080 --name javawebcontainer rammarx/java-web-app:${buildNumber}"
        }
    }
}
