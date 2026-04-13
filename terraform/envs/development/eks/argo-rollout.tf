resource "helm_release" "argo_rollout" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = "argo-rollouts"
  create_namespace = true
  version          = "2.40.6"

  values = [file("values/argo-rollout.yaml")]

  depends_on = [helm_release.aws_lbc]
}