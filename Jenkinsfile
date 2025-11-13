pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')    // Jenkins credentials
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    TF_VAR_aws_region     = "us-east-1"
  }
  parameters {
    booleanParam(name: 'APPLY', defaultValue: false, description: 'Set true to run terraform apply')
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        dir('.') {
          sh 'terraform --version'
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Terraform Format & Validate') {
      steps {
        sh 'terraform fmt -check'
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan -input=false'
      }
      post {
        always {
          sh 'terraform show -no-color tfplan > plan.txt || true'
          archiveArtifacts artifacts: 'plan.txt', fingerprint: true
        }
      }
    }

    stage('Terraform Apply') {
      when {
        expression { return params.APPLY == true }
      }
      steps {
        // For production: add manual approval or use a separate approver stage
        sh 'terraform apply -input=false -auto-approve tfplan'
      }
    }
  }
  post {
    success {
      echo "Terraform pipeline completed"
    }
    failure {
      echo "Terraform pipeline failed"
    }
  }
}
