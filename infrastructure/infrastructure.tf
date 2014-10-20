provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

resource "aws_security_group" "scraper" {
    name = "scraper"
    description = "Scraper group, allows ssh"

    ingress {
        from_port = 0
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "scraper" {
    ami = "ami-96981dfe"
    instance_type = "t1.micro"
    key_name = "brettaws"
    security_groups = ["${aws_security_group.scraper.name}"]
    count = 3
}

resource "aws_launch_configuration" "zookeeper" {
    name = "zookeeper"
    image_id = "ami-14aa2f7c"
    instance_type = "t1.micro"
    key_name = "brettaws"
    security_groups = ["${aws_security_group.scraper.name}"]
}

resource "aws_autoscaling_group" "zookeeper" {
    availability_zones = ["us-east-1a"]
    name = "zookeeper"
    max_size = 3
    min_size = 3
    health_check_grace_period = 300
    desired_capacity = 3
    force_delete = true
    launch_configuration = "${aws_launch_configuration.zookeeper.name}"
}
