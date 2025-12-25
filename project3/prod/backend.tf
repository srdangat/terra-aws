terraform {
  backend "s3" {
    bucket       = "sanket-dec2k25-tfstate"
    key          = "prodvpc.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}