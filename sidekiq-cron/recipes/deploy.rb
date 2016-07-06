node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  current_path = deploy[:current_path]

  Chef::Log.info("Updating sidekiq cron with environment #{rails_env}")

  execute 'rake sidekiq_cron:setup' do
    cwd current_path
    user 'deploy'
    command 'bundle exec rake sidekiq_cron:setup'
    environment 'RAILS_ENV' => rails_env
  end
end
