resource "aws_internet_gateway" "prod-igw" { # THis enable svpc to connect to the internet
    vpc_id = "${aws_vpc.prod-vpc.id}"
    tags {
        Name = "prod-igw"
    }
}

resource "aws_route_table" "prod-public-crt" {
    vpc_id = "${aws_vpc.main-vpc.id}"
  
    route {
        cidr_block = "0.0.0.0/0" #This subnet can reach anywhere
        gateway_id = "${aws_internet_gateway.prod-igw.id}"
    }
    tags {
        Name = "prod-public-crt"
    }
}

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    route_table_id = "${aws_route_table.prod-public-crt.id}"
}

#Security Group
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.prod-vpc.id}"

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_block = ["0.0.0.0/0"] 
     }
     ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_block = ["10.0.100.0/24"] #This subnet can have ssh access
     }
    tags {
        Name = "ssh-allowed"
    }
}

