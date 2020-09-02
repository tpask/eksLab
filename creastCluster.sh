#create eks:

nodes=1
maxNodes=3
minNodes=1
nodeType=t3.micro
nodeGrpName=standard-workder
name=dev-cluser

echo eksctl create cluster --name ${name} --nodegroup-name ${nodeGrpName} --node-type ${nodeType} --nodes ${nodes} --nodes-min ${minNodes} --nodes-max ${maxNodes} --managed

eksctl create cluster --name ${name} --nodegroup-name ${nodeGrpName} --node-type ${nodeType} --nodes ${nodes} --nodes-min ${minNodes} --nodes-max ${maxNodes} --managed