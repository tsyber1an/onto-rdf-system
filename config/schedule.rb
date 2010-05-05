 set :output, "~/prog/mmfdstat/log/cron_log.log"

 every 2.hours do
   rake "utils:paser"
 end
