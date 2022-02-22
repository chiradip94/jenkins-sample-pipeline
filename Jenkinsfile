podTemplate(label: 'agent', containers: [
  containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
  containerTemplate(name: 'k8s', image: 'chiradip94/kubectl-helm:latest', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ], serviceAccount: 'jenkins-agent') {
  node('agent') {
    def imageName = "webapplication"
    checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/chiradip94/jenkins-sample-pipeline.git']]])
    stage('Docker build') {
      container('docker') {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
        sh """
          docker build -t ${env.user}/${imageName}:${env.BUILD_NUMBER} .
          docker login -u ${env.user} -p ${env.pass}
          docker push ${env.user}/${imageName}:${env.BUILD_NUMBER}
          """
        }
      }
    }
    stage('Helm Deploy') {
      container('k8s') {
      sh """
         helm upgrade --install ${imageName} ./helm --set image.repository='${env.user}/${imageName}' --set image.tag='${env.BUILD_NUMBER}' -n apps --create-namespace
         """
      }
    }
  }
}
