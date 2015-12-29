default['amazon-ecs-agent']['log_folder'] = '/var/log/ecs'
default['amazon-ecs-agent']['data_folder'] = '/opt/ecs'
default['amazon-ecs-agent']['log_level'] = 'info'
default['amazon-ecs-agent']['cluster'] = 'default'
default['amazon-ecs-agent']['aws_access_key_id'] = nil
default['amazon-ecs-agent']['aws_secret_access_key'] = nil
default['amazon-ecs-agent']['tag'] = 'v1.0.0'
default['amazon-ecs-agent']['storage_driver'] = 'aufs'
default['amazon-ecs-agent']['docker_additional_binds'] = []
default['amazon-ecs-agent']['docker_additional_env'] = []
