resource "helm_release" "sealed_secrets" {
  name = "sealed-secrets"

  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  namespace        = "kube-system"
  version          = "2.18.5"


  depends_on = [helm_release.aws_lbc]
}