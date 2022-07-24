@Library('jenkins-shared-library@release') _

pipeline {

    agent {
        kubernetes(agents().helm().startContainers())
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

        stage("Helm Test") {
            steps {
                container("helm") {
                    sh 'helm unittest -o test-results.xml -t junit -3 $(find tests/**/test.yaml | sed \'s:tests/:-f tests/:g\') .'
                    junit 'test-results.xml'
                }
            }
        }

        stage("Helm Push") {
            when {
                not {
                    branch 'master'
                }
            }
            steps {
                script {
                    def version = "3.0.0-${GIT_COMMIT}"
                    currentBuild.displayName = version
                    helmPush tenant: 'shared', version: version
                }
            }
        }

        stage("Helm Release") {
            when {
                branch 'master'
            }
            steps {
                script {
                    def chart = readYaml file: 'Chart.yaml'
                    currentBuild.displayName = chart.version
                    helmPush tenant: 'shared'
                }
            }
        }
    }
}
