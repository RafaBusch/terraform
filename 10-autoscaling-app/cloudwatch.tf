resource "aws_cloudwatch_metric_alarm" "up" {
  alarm_name          = "asg-up"
  alarm_description   = "scales up ec2 when 30% utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1 #se passar uma vez ja dispara o alarm
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60 #1min
  statistic           = "Average"
  threshold           = 30 #nao pode passar de 30% de uso na cpu

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaleup.arn]
}

resource "aws_cloudwatch_metric_alarm" "down" {
  alarm_name          = "asg-down"
  alarm_description   = "scales down ec2 when 40% utilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1 #se passar uma vez ja dispara o alarm
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60 #1min
  statistic           = "Average"
  threshold           = 40 #nao pode passar de 30% de uso na cpu

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaledown.arn]
}