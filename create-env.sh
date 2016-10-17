#!/bin/bash
if [ "$#" -ne 5 ]; then
   echo "Missing parameters"
   echo -n "the parameters should be in the order:"
   echo -n " 1) AMI ID:"
   echo -n "2)keyname:"
   echo -n "3)security-group: "
   echo -n "4)launch-configuration:"
   echo -n "5)count:minimum 2 maximum 5"
   exit 0
else
echo "all parameters are present"
fi

aws elb create-load-balancer --load-balancer-name loadbalancerGreshma --listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 --subnets subnet-d1d0aba7


aws autoscaling create-launch-configuration --launch-configuration-name $4 --image-id $1 --key-name $2 --security-groups $3 --instance-type t2.micro --user-data file://installapp.sh 



aws autoscaling create-auto-scaling-group --auto-scaling-group-name autoScalingGroup --launch-configuration-name $4 --availability-zones us-west-2b --load-balancer-names loadBalancerGreshma --max-size 4 --min-size 1 --desired-capacity $5





