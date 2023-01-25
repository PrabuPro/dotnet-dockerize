// properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '2', numToKeepStr: '2']]]);

pipeline {
    /*     
    This pipeline is for packaging almost all project which respect some form
    We need to be the most generic terms

    */     
    agent any


    stages {
        stage('Checkout') {
            steps {
                // script {
                //     emailNotification.notifyStarted()
                // }
                checkout([$class: 'GitSCM', 
                            branches: [[name: "*/*/my-speos-easy2mail"]], 
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [[$class: 'RelativeTargetDirectory', 
                            relativeTargetDir: 'code']], 
                            submoduleCfg: [], 
                            userRemoteConfigs: [[credentialsId: 'prabu-speos', 
                            url: "https://gitlab.com/p5884/angular_ui.git"]]])
                script {
                    configFileProvider([configFile(fileId: '8d76a649-2847-4cce-9ab6-ad5c3ddeab09', targetLocation: '.npmrc')]) {
                    }
                }
                
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        def customImage = docker.build("${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${params.DOCKER_TAG}","--build-arg image=${env.DOCKER_REGISTRY_URL}${params.DOCKER_BUILD_IMAGE_NAME} --build-arg version=${params.DOCKER_BUILD_IMAGE_TAG} ." )
                        /** 
                            Problem related to the certificates authentication
                            Meanwhile sh is working fine
                        **/
                        sh "'docker' push ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${params.DOCKER_TAG}"
                        sh "'docker' rmi ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${params.DOCKER_TAG}"
                    }
                    catch (Exception e) {
                        script {
                            // emailNotification.notifyFailed()
                            throw e;
                        }
                    }
                    script {
                        // emailNotification.notifySuccessful()
                    }
                }
            }
        }
    }
}
