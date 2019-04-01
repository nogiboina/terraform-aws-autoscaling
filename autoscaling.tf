resource "aws_launch_configuration" "devops-launchconfig" {
 name_prefix 		= "devops-launchconfig"
 image_id 		= "${lookup(var.AMIS, var.AWS_REGION)}"
 instance_type 		= "${var.instance_type}"
 key_name 		= "${aws_key_pair.devopskeypair.key_name}"
 security_groups 	= ["${aws_security_group.devops-sg.id}"]
}

resource "aws_autoscaling_group" "devops-autoscaling" {
 name 			= "devops-autoscaling"
 vpc_zone_identifier	= ["${aws_subnet.main-pubsubnet-1.id}", "${aws_subnet.main-pubsubnet-2.id}"]
 launch_configuration	= "${aws_launch_configuration.devops-launchconfig.name}"
 min_size		= 1
 max_size		= 2
 health_check_grace_period = 300
 health_check_type	= "EC2"
 force_delete 		= true
 
 tag {
  key = "Name"
  value = "devops-ec2"
  propagate_at_launch= true
 }
}
