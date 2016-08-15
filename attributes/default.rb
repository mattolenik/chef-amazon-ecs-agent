default['amazon-ecs-agent']['log_folder'] = '/var/log/ecs'
default['amazon-ecs-agent']['data_folder'] = '/var/lib/ecs/data'
default['amazon-ecs-agent']['env_file'] = '/etc/default/ecs-agent'
default['amazon-ecs-agent']['log_level'] = 'info'
default['amazon-ecs-agent']['cluster'] = 'default'
default['amazon-ecs-agent']['tag'] = 'latest'
default['amazon-ecs-agent']['user'] = 'ubuntu'
default['amazon-ecs-agent']['storage_driver'] = 'overlay'
default['amazon-ecs-agent']['docker']['version'] = '1.11.2'
default['amazon-ecs-agent']['docker']['apt']['keyserver'] = 'hkp://p80.pool.sks-keyservers.net:80'
default['amazon-ecs-agent']['docker']['apt']['key'] = '58118E89F3A912897C070ADBF76221572C52609D'
default['amazon-ecs-agent']['docker_additional_binds'] = []
default['amazon-ecs-agent']['docker_additional_envs'] = [
    'ECS_ENABLE_TASK_IAM_ROLE=true'
]
