properties([
  parameters([
     string(defaultValue: 'https://github.com/chiradip94/jenkins-sample-pipeline.git', description: 'Url of the repository to build the image from', name: 'repoUrl'),
     string(defaultValue: 'main', description: 'Branch for the repository', name: 'repoBranch'),
     string(defaultValue: 'dockerhub', description: 'Credential id for registry', name: 'credentialID')
  ])
])
podTemplate(label: 'agent', containers: [
  containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat'),
  containerTemplate(name: 'k8s', image: 'chiradip94/kubectl-helm:latest', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  ], serviceAccount: 'jenkins-agent') {
  node('agent') {
    def imageName = "webapplication"
    checkout([$class: 'GitSCM', branches: [[name: "*/${params.repoBranch}"]], extensions: [], userRemoteConfigs: [[url: "${params.repoUrl}"]]])
    stage('Docker build') {
      container('docker') {
        withCredentials([usernamePassword(credentialsId: "${params.credentialID}", passwordVariable: 'pass', usernameVariable: 'user')]) {
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
        withCredentials([usernamePassword(credentialsId: "${params.credentialID}", passwordVariable: 'pass', usernameVariable: 'user')]) {
        sh """
           helm upgrade --install ${imageName} ./helm/webapplication --set image.repository='${env.user}/${imageName}' --set image.tag='${env.BUILD_NUMBER}' -n apps --create-namespace
           """
        }
      }
    }
  }
}
