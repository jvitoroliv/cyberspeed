resource "aws_autoscaling_schedule" "stop_at" {
  scheduled_action_name  = "stop_at"
  min_size               = 0
  max_size               = 1
  desired_capacity       = 0
  recurrence             = "0 21 * * 1-5"
  time_zone              = "Asia/Dubai"
  autoscaling_group_name = var.autoscaling_group_name
}

resource "aws_autoscaling_schedule" "start_at" {
  scheduled_action_name  = "start_at"
  min_size               = 1
  max_size               = 5
  desired_capacity       = 3
  recurrence             = "0 8 * * 1-5"
  time_zone              = "Asia/Dubai"
  autoscaling_group_name = var.autoscaling_group_name
}