set :environment, "development"
set :output, {:error => "log/cron_errors.log", :standard => "log/cron_log.log"}

every 1.day do
  rake 'app:notify_inactive_users'
end