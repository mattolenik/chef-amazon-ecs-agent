#
# Cookbook Name:: amazon-ecs-agent
# Recipe:: default
#
# Copyright (C) 2014 Will Salt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'chef-sugar'

package 'apt-transport-https' if ubuntu?

bash 'install_docker' do
  code <<-EOH
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    apt-get update
    apt-get install -y docker-ce=#{node['amazon-ecs-agent']['docker']['version']}
  EOH
end

# create the default log folder
directory node['amazon-ecs-agent']['log_folder'] do
  mode 0o0755
  action :create
end

directory node['amazon-ecs-agent']['data_folder'] do
  mode 0o0755
  recursive true
  action :create
end

package "linux-image-extra-#{node['kernel']['release']}" do
  only_if { node['amazon-ecs-agent']['storage_driver'] == 'aufs' }
end

# Allow the user to run containers
group 'docker' do
  action :modify
  members node['amazon-ecs-agent']['user']
  append true
end

# create the docker service
docker_service 'default' do
  fixed_cidr node['amazon-ecs-agent']['fixed_cidr']
  bip node['amazon-ecs-agent']['bip']
  storage_driver node['amazon-ecs-agent']['storage_driver']
  action [:create, :start]
end

# pull down the latest image
docker_image 'amazon/amazon-ecs-agent'

environment_variables = [
  'ECS_DATADIR=/data',
  'ECS_LOGFILE=/log/ecs-agent.log',
  "ECS_LOGLEVEL=#{node['amazon-ecs-agent']['log_level']}",
  "ECS_CLUSTER=#{node['amazon-ecs-agent']['cluster']}"
] + node['amazon-ecs-agent']['docker_additional_envs']

# write defaults env file, can be overriden by userdata
file node['amazon-ecs-agent']['env_file'] do
  action :create
  owner 'root'
  group 'root'
  mode '0644'
  content environment_variables.join("\n")
end

# Note: Not using the docker_container resource here to delay the creation
# of the container until boot. This allows us to override the value of the
# ECS_CLUSTER (and other vars) via EC2 user-data.
template '/var/lib/cloud/scripts/per-boot/run-ecs-agent.sh' do
  source 'run-ecs-agent.sh.erb'
  mode 0o0755
  variables(
    data_folder: node['amazon-ecs-agent']['data_folder'],
    env_file: node['amazon-ecs-agent']['env_file'],
    log_folder: node['amazon-ecs-agent']['log_folder'],
    tag: node['amazon-ecs-agent']['tag']
  )
  only_if 'test -d /var/lib/cloud/scripts/per-boot'
end
