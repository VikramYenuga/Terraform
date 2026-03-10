module "name" {
  source = "./localmodels/ec2"
  instance_type = var.instance_type
  number_of_instance = var.number_of_instance
}