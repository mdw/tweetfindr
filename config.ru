require '/usr/lib/ruby/gems/1.8/gems/sinatra-0.9.1.1/lib/sinatra.rb'
Sinatra::Application.default_options.merge!(
  :run => false,
  :env => :production
)
require '/var/www/tweetfindr.com/current/vend.rb'
run Sinatra:Application