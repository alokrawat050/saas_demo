require 'bundler/deployment'

SSHKit.config.command_map[:rake] = 'bundle exec rake'
SSHKit.config.command_map[:rails] = 'bundle exec rails'

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'gst'
set :repo_url, 'ssh://git-codecommit.us-west-2.amazonaws.com/v1/repos/gst-dev-repo'  #'git@bitbucket.org:onetaxgst/dev-gst.git' #'https://onetaxgst@bitbucket.org/onetaxgst/dev-gst.git'

## Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, '/home/gst/'
set :user, 'gstdev'
#set :user, 'contact'

# Default value for :scm is :git
set :scm, :git
#set :pty, true
#set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
## Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

## Default value for :linked_files is []
#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
#set :linked_files, %w(config/database.yml config/secrets.yml)

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10

set :stages, %w(production staging development)

set :default_stage, "development"

# Resque Worker Settings
# set :workers, { "mailer" => 1 }

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  #desc 'Update the crontab file'
  #task :update_crontab do
  #  on roles(:web, :app, :db) do
  #    execute 'crontab -r', raise_on_non_zero_exit: false
      #within release_path do
      #  execute :bundle, :exec, "whenever --update-crontab", raise_on_non_zero_exit: false
      #end
  #    within current_path do
  #      execute :bundle, :exec,"whenever --update-crontab RAILS_ENV='staging'", raise_on_non_zero_exit: false
  #    end
  #  end
  #end

  #after :deploy, 'deploy:update_crontab'
  
  ## Resque service
  #after "deploy:restart", "resque:restart"
end
