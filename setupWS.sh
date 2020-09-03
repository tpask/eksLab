keyname=eksworkshop
roleName=eksworkshop-admin
instProfileName=c9
export instanceId=${curl http://169.254.169.254/latest/meta-data/instance-id}
export AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)

#setup EKS env
sudo yum install -y jq 
sudo yum install -y bash-completion

#setup kubectl:
sudo curl --silent --location -o /usr/local/bin/kubectl   https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl

#install aws cli v2:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

#install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

#setup environment
ssh-keygen
aws ec2 import-key-pair --key-name "eksworkshop" --public-key-material fileb://~/.ssh/id_rsa.pub

#
echo $AWS_REGION
test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set
ACCOUNT_ID=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document |jq -r .accountId)
export ACCOUNT_ID=${ACCOUNT_ID} | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region

#setup role:
aws ec2 associate-iam-instance-profile --instance-id ${instanceId} --iam-instance-profile Name=${instProfileName}
rm -f ~/.aws/credentials



