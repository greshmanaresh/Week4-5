#!/bin/bash

aws rds create-db-instance --engine mysql --db-name dev --db-instance-identifier gn-application --db-instance-class db.t2.micro --master-username controller --master-user-password controller -
-allocated-storage 5 --availability-zone us-west-2b

aws rds wait db-instance-available --db-instance-identifier gn-application
