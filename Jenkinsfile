pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-id' // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE = 'mostafagheta/jenkins_test' // Docker Hub repository
        DOCKER_TAG = 'latest' // Tag for the image
        GITHUB_REPO = 'https://github.com/mostafagheta/jenkins_test' // GitHub repo URL
        BRANCH = 'main' // Branch to build from
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the code from GitHub
                git branch: "$BRANCH", url: "$GITHUB_REPO"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using credentials stored in Jenkins
                    withCredentials([usernamePassword(credentialsId: "$DOCKERHUB_CREDENTIALS", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Run Docker login command using credentials from Jenkins
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

    }

    post {
        success {
            echo 'Build and push to Docker Hub successful.'
        }
        failure {
            echo 'Build failed. Check logs for details.'
        }
        
    }
}
