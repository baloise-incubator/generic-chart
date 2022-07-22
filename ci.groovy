@Library('jenkins-shared-library@release') _

pipeline {

    agent {
        label 'podman'
    }

    options {
        skipStagesAfterUnstable()
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '28'))
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }

    stages {
        stage("Helm Lint") {
            steps {
                helmLint()
            }
        }

        stage("Helm Push") {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                helmPush tenant: 'shared', version: "3.0.0-${GIT_COMMIT}"
            }
        }

        stage("Helm Release") {
            when {
                branch 'master'
            }
            steps {
                helmPush tenant: 'shared'
            }
        }
    }

    post {
        success {
            notifyBitBucket state: "SUCCESSFUL"
        }

        fixed {
            mailTo status: "SUCCESS", actuator: true, recipients: [], logExtract: true
        }

        failure {
            notifyBitBucket state: "FAILED"
            mailTo status: "FAILURE", actuator: true, recipients: [], logExtract: true
        }
    }
}