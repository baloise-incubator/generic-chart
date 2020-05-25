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
        stage("Checkout") {
            steps {
                gitcheckout url: "https://bitbucket.balgroupit.com/scm/container/generic-chart.git",
                        branch: "master"
            }
        }
        stage("Helm Push") {
            steps {
               helmPush tenant: 'shared', organisation: "openshift"
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
