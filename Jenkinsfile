pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '15'))
        disableConcurrentBuilds()
    }
    environment {
      PATH = "/usr/local/bin/:$PATH"
    }
    stages {
        stage('Preparation') {
            steps {
                checkout scm
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '.demo-data-ref-distro/']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/OpenLMIS/openlmis-ref-distro.git']]])

                withCredentials([usernamePassword(
                  credentialsId: "cad2f741-7b1e-4ddd-b5ca-2959d40f62c2",
                  usernameVariable: "USER",
                  passwordVariable: "PASS"
                )]) {
                    sh 'set +x'
                    sh 'docker login -u $USER -p $PASS'
                }
            }
            post {
                failure {
                    slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${env.STAGE_NAME} FAILED (<${env.BUILD_URL}|Open>)"
                }
            }
        }
        stage('Build') {
            steps {
                sh '''
                    rm -vrf data/schema/
                    rm -vrf data/demo-data/

                    cd .demo-data-ref-distro
                    mv -v settings-sample.env settings.env

                    /usr/local/bin/docker-compose -f docker-compose.yml pull
                    /usr/local/bin/docker-compose -f docker-compose.yml -p demo-data-ref-distro up --no-start
                    cd ..

                    for cid in $(docker ps -a -q --filter name=demo-data-ref-distro); do
                        docker cp "$cid":/schema data 2>/dev/null || true
                        docker cp "$cid":/demo-data data 2>/dev/null || true
                    done

                    mkdir -vp data/demo-data/
                    mv -v data/*.csv data/demo-data/

                    cd .demo-data-ref-distro
                    /usr/local/bin/docker-compose -f docker-compose.yml down -v

                    cd ..
                    rm -vrf .demo-data-ref-distro/
                '''
            }
            post {
                failure {
                    slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${env.STAGE_NAME} FAILED (<${env.BUILD_URL}|Open>)"
                }
            }
        }
        stage('Build and push image') {
            steps {
                sh "docker build -t openlmis/demo-data ."
                sh "docker push openlmis/demo-data"
            }
            post {
                failure {
                    slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} ${env.STAGE_NAME} FAILED (<${env.BUILD_URL}|Open>)"
                }
            }
        }
    }
    post {
        fixed {
            slackSend color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Back to normal"
        }
    }
}
