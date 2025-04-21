resource "aws_key_pair" "project_key" {
  key_name   = "project-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Make sure to set your own public key path
}
