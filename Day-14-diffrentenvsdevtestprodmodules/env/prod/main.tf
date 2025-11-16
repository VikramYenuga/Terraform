

provider "aws" {
  region = var.region
  profile = "dev"
}

module "vpc" {
  source              = "../../modules/vpc"
  cidr_block          = var.vpc_cidr
  availability_zone1  = var.availability_zone1   # ✅ Correct argument
  availability_zone2  = var.availability_zone2   # ✅ Add this argument
  public_subnet_id  = var.public_subnet_id
  env                 = var.env
  subnet_1_id         = var.subnet_1_id
  subnet_2_id         = var.subnet_2_id
}
module "ec2" {
    source = "../../Modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    env = var.env
    public_subnet_id = module.vpc.public_subnet_id
  
}


module "rds" {
  source         = "../../modules/rds"
  subnet_1_id      = module.vpc.subnet_1_id
  subnet_2_id      = module.vpc.subnet_2_id
  db_instance_class = var.db_instance_class
  db_name        = var.db_name
  db_user        = var.db_user
  db_password    = var.db_password
  env = var.env
}


module "s3" {
    source = "../../modules/s3"
    bucket = var.aws_s3_bucket
  
}