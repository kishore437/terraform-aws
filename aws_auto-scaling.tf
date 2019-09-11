################### aws autoscaling group ##################

resource "aws_launch_template" "cloud-geek" {
  name_prefix   = "example"
  image_id      = "${var.webservers_ami}"
  instance_type = "${var.instance_type}"
}

resource "aws_autoscaling_group" "cloud-geek" {
  availability_zones = ["ap-southeast-2a"]
  desired_capacity   = 1
  max_size = 1
  min_size = 1

  launch_template {
    id      = "${aws_launch_template.cloud-geek.id}"
    version = "$Latest"
  }

  tag {
    key = "cloud"
    value = "geek"
    propagate_at_launch = true
  }
 }

