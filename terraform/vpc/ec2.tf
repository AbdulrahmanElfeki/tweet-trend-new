resource "aws_instance" "server" {
    ami = "ami-0427090fd1714168b"
    instance_type = "t2.micro"
    key_name = ""
    for_each = toset(["jenkins_master","jenkins_slave","ansible"])
    tags = { Name="${each.key}" }
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.subnet1.id

}
