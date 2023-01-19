pipeline {
    /*     
    This pipeline is for packaging almost all project which respect some form
    We need to be the most generic terms

    */     
    agent any
    environment {
        DIRECTORY_SRC= "code"
        DOCKER_TAG_RELEASE="";
    }

    stages {
        stage('Checkout') {
            steps {
                // Clean code folder before checkout
                dir("${DIRECTORY_SRC}") {
                    checkout([$class: 'GitSCM', 
                                branches: [[name: "*/${params.GIT_BRANCH}"]], 
                                doGenerateSubmoduleConfigurations: false, 
                                extensions: [[$class: 'LocalBranch', localBranch: "**"]],
                                submoduleCfg: [], 
                                userRemoteConfigs: [[credentialsId: 'prabu-speos', 
                                url: "https://gitlab.com/p5884/angular_ui.git"]]])
                }
                sh 'mkdir .ssh'
                // script {
                //     // Drop Useful files
                //     configFileProvider([
                //             // SSH
                //             configFile(fileId: 'adaf33d8-22c6-411e-b72a-d6f117a77970', targetLocation: '.ssh/known_hosts'),
                //             configFile(fileId: '9ce8d47d-d08c-4e6f-bab3-09535c422cc2', targetLocation: '.ssh/id_rsa'), 
                //             // Git
                //             configFile(fileId: 'dcaf2156-df25-4cb9-b836-e526ac7548e5', targetLocation: '.gitconfig'), 
                //             // Maven
                //             configFile(fileId: '6285847a-3fca-4ae4-b727-78be3962284b', targetLocation: '.m2/settings.xml'), 
                //             configFile(fileId: 'a19bea50-48d4-4a9e-a61b-8ab3a590a06e', targetLocation: '.m2/settings-security.xml')]) {
                //     }
                // }
            }
        }

        // stage('Build') {
        //     steps {
        //         script {
        //             try {    
        //                 def customImage = docker.build("${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${env.BUILD_NUMBER}", "--no-cache --add-host=${env.GITLAB_REPOSITORY_HOST} --add-host=${env.SONAR_HOST} --add-host=${env.MAVEN_REPOSITORY_HOST} --build-arg image=${env.DOCKER_REGISTRY_URL}${params.DOCKER_BUILD_IMAGE_NAME} --build-arg version=${params.DOCKER_BUILD_IMAGE_TAG} --build-arg git_url=${params.GIT_URL} --build-arg git_branch=${params.GIT_BRANCH} --build-arg target_image=${env.DOCKER_REGISTRY_URL}${params.DOCKER_FINAL_IMAGE_NAME} --build-arg target_version=${params.DOCKER_FINAL_IMAGE_TAG} --build-arg src_target_path_jar=${params.SRC_TARGET_PATH_JAR} --build-arg dst_target_path_jar=${params.DST_TARGET_PATH_JAR} --build-arg cli=\"${params.MAVEN_CLI}\"  .")
        //                  dir("${DIRECTORY_SRC}") {
        //                     sshagent(['6fa7a3b0-e641-4160-93d9-b045302d9f87']) {
        //                         // Update
        //                         sh "git checkout ${params.GIT_BRANCH} && git pull origin ${params.GIT_BRANCH} --tags"
        //                         DOCKER_TAG_RELEASE = sh (
        //                             script: "git describe --abbrev=0 --tags ${params.GIT_BRANCH}",
        //                                     returnStdout: true
        //                             )
        //                     }
        //                 }
        //                 sh "'docker' tag ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${env.BUILD_NUMBER} ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${DOCKER_TAG_RELEASE}"
        //                 sh "'docker' push ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${DOCKER_TAG_RELEASE}"
        //                 sh "'docker' rmi ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${DOCKER_TAG_RELEASE}"
        //                 sh "'docker' rmi ${env.DOCKER_REGISTRY_URL}${params.DOCKER_IMAGE}:${env.BUILD_NUMBER}"
        //             } catch (Exception e) {
        //                 //emailNotification.notifyFailed()
        //                 throw e;
        //             }
        //         }
        //     }
        // }

        // stage('Merge into validation') {
        //     steps {
        //         script {
        //             try { 
        //                 def customImage = docker.build("${env.JOB_NAME}:${env.BUILD_NUMBER}",
        //                     "-f release-merge.Dockerfile --no-cache --build-arg image=${env.DOCKER_REGISTRY_URL}${params.DOCKER_BUILD_IMAGE_NAME} --build-arg version=${params.DOCKER_BUILD_IMAGE_TAG} --build-arg git_target_branch=${params.GIT_TARGET_BRANCH} --build-arg git_source_branch=${params.GIT_BRANCH} --build-arg git_url=${params.GIT_URL} --add-host=${env.GITLAB_REPOSITORY_HOST} ." )
        //                 sh "'docker' rmi ${env.JOB_NAME}:${env.BUILD_NUMBER}"
        //             } catch (Exception e) {
        //                 emailNotification.notifyFailed()
        //                 throw e;
        //             }
        //             emailNotification.notifySuccessful()
        //         }
        //     }
        // }
    }
}