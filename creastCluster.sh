#create eks:

nodes=1
maxNodes=3
minNodes=1
nodeType=t3.small
nodeGrpName=standard-worker
name=dev-cluster
AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

echo eksctl create cluster --region ${AWS_REGION} --name ${name} --nodegroup-name ${nodeGrpName} --node-type ${nodeType} --nodes ${nodes} --nodes-min ${minNodes} --nodes-max ${maxNodes} --managed
eksctl create cluster --region ${AWS_REGION} --name ${name} --nodegroup-name ${nodeGrpName} --node-type ${nodeType} --nodes ${nodes} --nodes-min ${minNodes} --nodes-max ${maxNodes} --managed

echo updating kube configuration....
aws eks update-kubeconfig --name ${name} --region ${AWS_REGION}
