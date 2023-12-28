
## High Order Execution
ENV < Custom < CLI | terraform.tfvars


## Env Vars
```sh
$ export TF_VAR_<var_string> = "value"
$ export TF_VAR_<var_list> = '["vm1", "vm2", "vm3"]'
```

## Custom var file
```sh
$ terraform apply -var-file=<file_name>.tfvars
```

## By CLI
```sh
$ terraform apply -var="var_name='Valor da variável'" -var="var_name2='Valor da outra variável' -var=..."
```