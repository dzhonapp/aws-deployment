resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" #enable internal domain name
    enable_dns_hostnames = "true" #enable internal hostname
    enable_classiclink = "false"
    instance_tenancy = "default"
    tags {
            Name = "prod-vpc"
    }
}

resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.0.100.0/24"
    map_public_ip_on_launch = "true" # This is public subnet
    tags {
        Name = "prod-subnet-public-1"
    }
}