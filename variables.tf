variable "project_id" {
  type = string
  default = "playground-s-11-f1e6f897"
}

variable "subnet_name_list" {
  type  = list
  default = ["us-central1","us-west1","us-west2","us-east1"]
}

variable "subnet_cidr_list" {
  type  = list
  default = ["10.0.0.0/16","10.1.0.0/16","10.3.0.0/16","10.2.0.0/16"]
}
