#AutoScaling Launch Configuration
resource "aws_launch_configuration" "lionel-launchconfig" {
  name_prefix     = "lionel-launchconfig"
  image_id        = lookup(var.AMIS, var.AWS_REGION)
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.lionel_key.key_name
}

#Generate Key
resource "aws_key_pair" "lionel_key" {
    key_name = "lionel_key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Autoscaling Group
resource "aws_autoscaling_group" "lionel-autoscaling" {
  name                      = "lionel-autoscaling"
  vpc_zone_identifier       = ["subnet-0b9ae6432d8aa6640", "subnet-0ab0d3ad4dde701a6"]
  launch_configuration      = aws_launch_configuration.lionel-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "lionel Custom EC2 instance"
    propagate_at_launch = true
  }
}

#Autoscaling Configuration policy - Scaling Alarm
resource "aws_autoscaling_policy" "lionel-cpu-policy" {
  name                   = "lionel-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.lionel-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}

#Auto scaling Cloud Watch Monitoring
resource "aws_cloudwatch_metric_alarm" "lionel-cpu-alarm" {
  alarm_name          = "lionel-cpu-alarm"
  alarm_description   = "Alarm once CPU Uses Increase"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.lionel-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.lionel-cpu-policy.arn]
}

#Auto Descaling Policy
resource "aws_autoscaling_policy" "lionel-cpu-policy-scaledown" {
  name                   = "lionel-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.lionel-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}

#Auto descaling cloud watch 
resource "aws_cloudwatch_metric_alarm" "lionel-cpu-alarm-scaledown" {
  alarm_name          = "lionel-cpu-alarm-scaledown"
  alarm_description   = "Alarm once CPU Uses Decrease"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.lionel-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.lionel-cpu-policy-scaledown.arn]
}