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
                    rm -rf data/schema/
                    rm -rf data/demo-data/

                    cd .demo-data-ref-distro
                    mv settings-sample.env settings.env
                    sed -i '' -e "s#spring_profiles_active=.*#spring_profiles_active=#" settings.env  2>/dev/null || true
                    export OL_HTTP_PORT=8085

                    /usr/local/bin/docker-compose -f docker-compose.yml pull
                    /usr/local/bin/docker-compose -f docker-compose.yml up &
                    sleep 300
                    cd ..
                    for cid in $(docker ps -a -q --filter name=demo-data-ref-distro); do
                        docker cp "$cid":/schema data 2>/dev/null || true
                        docker cp "$cid":/demo-data data 2>/dev/null || true
                    done
                    mv data/*.csv data/demo-data/

                    cd .demo-data-ref-distro
                    /usr/local/bin/docker-compose -f docker-compose.yml down -v

                    cd ..
                    rm -rf .demo-data-ref-distro/
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
        success {
            build job: 'OpenLMIS-3.x-deploy-to-test', wait: false
        }
    }
}