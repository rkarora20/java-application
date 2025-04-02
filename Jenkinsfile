pipeline {
    agent any
    environment {
        AWS_REGION = 'ca-central-1'
        ECR_REPOSITORY = 'spring-boot-demo'
        ECS_CLUSTER = 'spring-boot-cluster'
        ECS_SERVICE = 'spring-boot-service'
        ECS_TASK_DEFINITION = 'spring-boot-app'
    }
    stages {
        stage('List Workspace Files') {
            steps {
                sh 'ls -la'
            }
        }
    	stage('Build') {
	    steps {
        	echo "*********Build Started**********"
        	script 
            	sh 'docker build -t ${ECR_REPOSITORY}:${IMAGE_TAG} -f Dockerfile .'
        }
    }

        stage('Login to ECR') {
            steps {
                script {
                    sh """
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin 209479282299.dkr.ecr.ca-central-1.amazonaws.com
                    """
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh """
                        docker tag $ECR_REPOSITORY:latest 209479282299.dkr.ecr.ca-central-1.amazonaws.com/$ECR_REPOSITORY:latest
                        docker push 209479282299.dkr.ecr.ca-central-1.amazonaws.com/$ECR_REPOSITORY:latest
                    """
                }
            }
        }
        stage('Deploy to ECS') {
            steps {
                script {
                    sh """
                        aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE --task-definition $ECS_TASK_DEFINITION
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}

