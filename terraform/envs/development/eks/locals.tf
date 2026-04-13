locals {
  env = "development"
  cluster_name = "food-fiesta"
  eks_version = "1.35"
  aws_alb_service_account_name = "aws-load-balancer-controller"
  image_updater_service_account_name = "argocd-image-updater-sa"
}