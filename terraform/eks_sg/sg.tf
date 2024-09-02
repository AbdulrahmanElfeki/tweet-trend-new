resource "aws_security_group" "worker_node_sg" {
  name        = "eks-test"
  description = "Allow ssh inbound traffic"
  vpc_id      =  var.vpc_id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "k8s access"
    from_port        = 30082
    to_port          = 30082
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
