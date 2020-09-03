#create eks:

nodes=1
maxNodes=3
minNodes=1
nodeType=t3.small
AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
nodeGrpName=standard-worker
name=dev-cluster

echo eksctl create cluster --region ${AWS_REGION} --name ${name} --nodegroup-name ${nodeGrpName} --node-type ${nodeType} --nodes ${nodes} --nodes-min ${minNodes} --nodes-max ${maxNodes} --managed

eksctl create cluster --region ${AWS_REGION} --name ${name} --nodegroup-name ${nodeGrpName} --node-type ${nodeType} --nodes ${nodes} --nodes-min ${minNodes} --nodes-max ${maxNodes} --managed
