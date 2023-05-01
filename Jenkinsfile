pipeline {
  agent any

  stages {

    stage('Checkout') {
        steps {
            git branch: 'main', credentialsId: 'akshay-github', url: 'git@github.com:akshay27473/etp_epam.git'
        }
    }

    stage('Terraform') {
      steps {
        script {
          if (params.Action == "apply") {
            withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'akshay-aws',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY' ]]){
                         sh 'terraform init terraform/static-site'
                         sh 'terraform apply  -region=us-east-1   --auto-approve terraform/static-site'
                    }
           
          } 
          else {
            sh 'terraform destroy   -region=us-east-1   --auto-approve terraform/static-site'
          }
        }
      }
    }

    stage('Ansible') {
      steps {
        retry(count: 5) {
          sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/static-site/site.yaml'
        }
      }
    }
  }
}
