terraform {
backend "s3" {
bucket = "terrafor-state-april-class-okan"
key = "jenkins/us-east-1/tools/oregon/jenkins.tfstate"
region = "us-east-1"
  }
}
