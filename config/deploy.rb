$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require 'bundler/capistrano'
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user

before "deploy",         "deploy:check_id_rsa"
before "deploy",         "deploy:check_pem"


# Domains
set :dev_domain,            'www.dev.doxsite.com'

set :application,           "api-consumer"
set :scm,                   :git # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :repository,            "git@github.com:paulbrodner/API-Test.git"
set :branch,                'master'

set :user,                  "ubuntu"
set :use_sudo,              false

set :deploy_to,             "/var/www/#{application}"
set :deploy_via,            :remote_cache
set :keep_releases,         2

set :ssh_options,           { :forward_agent => true, :port => 22, :keys => [ "#{ENV['HOME']}/.ssh/osf.pem" ] }



role :web, dev_domain                          # Your HTTP server, Apache/etc
role :app, dev_domain                          # This may be the same as your `Web` server
role :db,  dev_domain, :primary => true        # This is where Rails migrations will run

#after "deploy", "deploy:bundle_gems"
#after "deploy:bundle_gems", "deploy:restart"


# for Passenger mod_rails 
namespace :deploy do
  #  desc "Run Bundle Install"
  #  #you will see the current gems installed
  #  task :bundle_gems do
  #    run "cd #{deploy_to}/current && bundle install vendor/gems"
  #  end
  
  task :start do ; end
  task :stop do ; end

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :check_pem do
    exists = File.exists?( ssh_options[:keys][0] )
    if( !exists )
      puts "it seems there's no pem file (looking for #{ssh_options[:keys][0]})"
      exit
    else
      puts "pem file found!!!!"
    end
  end
  
  task :check_id_rsa do
    if( File.exists?( '/home/vagrant/' ) )
      exists = File.exists?( '/home/vagrant/.ssh/id_rsa' )
      if( !exists )
        puts "it seems this is a vagrant VM and there's no id_rsa file (looking for /home/vagrant/.ssh/id_rsa)"
        exit
      else
        puts "found id_rsa file!!!"
      end
    end
  end
end