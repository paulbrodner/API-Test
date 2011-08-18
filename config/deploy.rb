require 'fileutils'

# Domains
set :dev_domain,            'www.dev.doxsite.com'

set :application,           "api-consumer"
set :repository,            "git@github.com:paulbrodner/API-Test.git"

set :user,                  "ubuntu"
set :use_sudo,              false
set :deploy_to,             "/var/www/#{application}"
set :api_config,            "/var/api_consumer_config/current"
set :deploy_via,            :remote_cache
set :ssh_options,           { :forward_agent => true, :port => 22, :keys => [ "#{ENV['HOME']}/.ssh/osf.pem" ] }

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, dev_domain                          # Your HTTP server, Apache/etc
role :app, dev_domain                          # This may be the same as your `Web` server
role :db,  dev_domain, :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

before "deploy",         "deploy:check_id_rsa"
before "deploy",         "deploy:check_pem"
#after  "deploy:update_code",  "deploy:copy_files"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :check_pem do
    exists = File.exists?( ssh_options[:keys][0] )
    if( !exists )
      puts "it seems there's no pem file (looking for #{ssh_options[:keys][0]})"
      exit
    end
  end

  task :check_id_rsa do
    if( File.exists?( '/home/vagrant/' ) )
      exists = File.exists?( '/home/vagrant/.ssh/id_rsa' )
      if( !exists )
        puts "it seems this is a vagrant VM and there's no id_rsa file (looking for /home/vagrant/.ssh/id_rsa)"
        exit
      end
    end
  end

  task :copy_files do
    FileUtils.cp_r "#{deploy_to}/shared/cached-copy", "#{deploy_to}/current", :verbose => true
    FileUtils.cp_r "#{api_config}", "#{deploy_to}/current", :verbose => true
  end
  
end