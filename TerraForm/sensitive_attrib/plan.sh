terraform init
terraform plan -out=tfplan
terraform show -json tfplan | jq > plan.json
rm tfplan
rm -rf .terraform