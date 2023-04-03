node{
   stage('SCM Checkout'){
     git credentialsId: 'node-pj', url: 'https://github.com/st-naresh/c-code-project.git'
   }
   stage('build'){
       cmakeBuild buildDir: 'build', cleanBuild: true, generator: 'Ninja', installation: 'cmake', steps: [[args: 'all install', envVars: 'DESTDIR=${WORKSPACE}/artifacts']]
   }
   stage('SonarQube Analysis') {
        def scannerHome = tool 'sonarscanner4'
        withSonarQubeEnv('sonar-pro') {
            sh """/var/lib/jenkins/tools/hudson.plugins.sonar.SonarRunnerInstallation/sonarscanner4/bin/sonar-scanner \
            -D sonar.projectVersion=1.0-SNAPSHOT \
            -D sonar.login=admin \
            -D sonar.password=admin \
            -D sonar.projectBaseDir=/var/lib/jenkins/workspace/python-sample/ \
            -D sonar.projectKey=c-project \
            -D sonar.sourceEncoding=UTF-8 \
            -D sonar.language=c \
            -D sonar.host.url=http://180.151.249.202:9000/"""
        }
    }
    stage('Build Docker Images'){
   sh 'docker build -t comdevops/c-project:v1 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u comdevops -p ${dockerPassword}"
    }
   sh 'docker push comdevops/c-project:v1'
   }
}
