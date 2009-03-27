# vend.rb - who knows what it does?
%w(rubygems sinatra haml rfeedparser).each { |gem| require gem }

configure do
	SourceUrl = ' &nbsp; (<a href="http://github.com/mdw/twitvend/master">the source</a>)'
	Credits = 'Powered by <a href=/sinatra>Sinatra</a> and <a href=/twitter>Twitter</a> &nbsp; (' + SourceUrl
	TwitterSearchURL = "http://search.twitter.com/search.atom?q="
end


get '/' do
	haml :howto
end

get '/:tag' do |t|
	headers 'Content-Type' => 'text/html; charset=utf-8'
  @searchchar = t =~ /^\@/ ? '%3A' : '%23'  # %23 is hash # symbol, %3A is the @ symbol
	res = FeedParser.parse(TwitterSearchURL + @searchchar + t)
	@entries = res.entries
	haml :show
end

