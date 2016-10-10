#!/bin/bash 

aws elb create-load-balancer --load-balancer-name loadBalancerGreshma --listeners "Protocol=Http,LoadBalancerPort=80,InstanceProtocol=Http,InstancePort=80" --subnets subnet-7bcab10d --security-groups sg-4bb66332 


aws autoscaling create-launch-configuration --launch-configuration-name autoScalingGreshma --image-id ami-06b94666 --key-name userOne --security-groups sg-4bb66332 --instance-type t2.micro --user-data file://installapp.sh 


aws autoscaling create-auto-scaling-group --auto-scaling-group-name autoScalingGroup --launch-configuration-name autoScalingGreshma --availability-zones us-west-2b --load-balancer-names loadBalancerGreshma --max-size 4 --min-size 1 --desired-capacity 3



