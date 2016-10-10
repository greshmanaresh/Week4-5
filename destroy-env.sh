#!/bin/bash

instanceId=`aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --filter Name=instance-state-name,Values=running`

aws ec2 terminate-instances --instance-ids $instanceId --output text --query 'TerminatingInstances[*].CurrentState.Name'

aws ec2 wait instance-terminated --instance-ids $instanceId

aws elb deregister-instances-from-load-balancer --load-balancer-name loadBalancerGreshma --instances $instanceId

aws elb delete-load-balancer-listeners --load-balancer-name loadBalancerGreshma --load-balancer-ports 80

aws elb delete-load-balancer --load-balancer-name loadBalancerGreshma 

aws autoscaling update-auto-scaling-group --auto-scaling-group-name autoScalingGroup --launch-configuration-name autoScalingGreshma --min-size 0 --max-size 0

aws autoscaling delete-auto-scaling-group --auto-scaling-group-name autoScalingGroup --force-delete  

aws autoscaling delete-launch-configuration --launch-configuration-name autoScalingGreshma
