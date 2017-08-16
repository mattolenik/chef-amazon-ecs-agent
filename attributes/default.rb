default['amazon-ecs-agent']['log_folder'] = '/var/log/ecs'
default['amazon-ecs-agent']['data_folder'] = '/var/lib/ecs/data'
default['amazon-ecs-agent']['env_file'] = '/etc/default/ecs-agent'
default['amazon-ecs-agent']['log_level'] = 'info'
default['amazon-ecs-agent']['cluster'] = 'default'
default['amazon-ecs-agent']['tag'] = 'latest'
default['amazon-ecs-agent']['user'] = 'ubuntu'
default['amazon-ecs-agent']['storage_driver'] = 'overlay'
default['amazon-ecs-agent']['docker']['version'] = '17.05.0'
default['amazon-ecs-agent']['docker_additional_binds'] = []
default['amazon-ecs-agent']['docker_additional_envs'] = [
  'ECS_ENABLE_TASK_IAM_ROLE=true'
]
default['amazon-ecs-agent']['fixed_cidr'] = '10.192.0.0/16'
default['amazon-ecs-agent']['bip'] = '10.192.0.1/16'
