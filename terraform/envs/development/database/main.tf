
module database {
    source = "../../../modules/database"

    db_name = "foodfiesta"
    env = "development"
    is_production_env = false
    password_ssm_pm_name = "/foodfiesta/development/database-password"
    sg_id = data.terraform_remote_state.vpc.outputs.db_sg_id
    subnet_ids = data.terraform_remote_state.vpc.outputs.db_subnet_ids
}