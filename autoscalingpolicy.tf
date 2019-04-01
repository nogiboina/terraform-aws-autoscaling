# Create a template for scaling up

resource "aws_autoscaling_policy" "devops-cpu-policy" {
 name			= "devops-cpu-policy"
 autoscaling_group_name = "${aws_autoscaling_group.devops-autoscaling.name}"
 adjustment_type        = "ChangeInCapacity"
 scaling_adjustment     = "1"
 cooldown               = "300"
 policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "devops-cpu-alarm" {
  alarm_name                = "devops-cpu-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "40"
  alarm_description         = "devops-cpu-alarm"
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.devops-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.devops-cpu-policy.arn}"]
}

# Create a template for scaling down
resource "aws_autoscaling_policy" "devops-cpu-policy-scaledown" {
 name                   = "devops-cpu-policy-scaledown"
 autoscaling_group_name = "${aws_autoscaling_group.devops-autoscaling.name}"
 adjustment_type        = "ChangeInCapacity"
 scaling_adjustment     = "-1"
 cooldown               = "300"
 policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "devops-cpu-alarm-scaledown" {
  alarm_name                = "devops-cpu-alarm-scaledown"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "5"
  alarm_description         = "devops-cpu-alarm-scaledown"
  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.devops-autoscaling.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.devops-cpu-policy-scaledown.arn}"]
}

