## Terraform S3 Backend

Migrate State into remote backend:

```bash
terraform init -migrate-state -backend-config="./state.config"
```