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
    ami = "ami-bc9015d4"
    instance_type = "t1.micro"
    key_name = "brettaws"
    count = 1
    security_groups = ["${aws_security_group.scraper.name}"]
}

