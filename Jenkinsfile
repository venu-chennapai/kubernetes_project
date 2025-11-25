node {
    stage('Git checkout') {
        git branch: 'kubernetes-demo-1', url: 'https://github.com/venu-chennapai/kubernetes_project.git'
    }
    stage('Send Dockerfile to Ansible Server via SSH') {
        sshagent(['ansible-sample-00.1']) {
            // Copy Dockerfile to Ansible server
            sh '''
                scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/pipeline-demo-1/* ubuntu@172.31.18.92:/home/ubuntu/
            '''

            // Verify file on remote host
            sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "ls -l /home/ubuntu/"
            '''
        }
    }
    stage('Docker Build Image') {
        sshagent(['ansible-sample-00.1']) {
            sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "
                cd /home/ubuntu && 
                docker build -t myapp:latest .
                "
            '''
        }
    }
    stage('Docker image tagging') {
        sshagent(['ansible-sample-00.1']) {
        sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "
                cd /home/ubuntu && 
                docker tag myapp:latest venu8179/myapp:latest
            "
        '''
        }
    }
    stage('Push docker image into docker hub'){
        sshagent(['ansible-sample-00.1']) {
        withCredentials([string(credentialsId: 'dockerhub_passwd', variable: 'dockerhub_passwd')]) {
            sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "
                    docker login -u venu8179 -p $dockerhub_passwd &&
                    docker push venu8179/myapp:latest
                "
            '''
            sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "
                    docker image rm venu8179/myapp:latest myapp:latest
                "
            '''
         }
       }
    }
        stage('copy files from ansible to kubernetes server'){
        sshagent(['kubernetes_server']) {
            sh '''
               ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "
               scp -o StrictHostKeyChecking=no /home/ubuntu/* ubuntu@172.31.25.47:/home/ubuntu/"
              '''
        }
    }
    stage('Kubernetes Deployment by using ansible'){
        sshagent(['ansible-sample-00.1']) {
        sh '''
            ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 << 'EOF'
            cd /home/ubuntu
            ansible-playbook ansible.yml
EOF
        '''
    }
        
    }
    
}
