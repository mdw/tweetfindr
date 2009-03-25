# vend.rb - who knows what it does?
%w(rubygems sinatra haml rfeedparser).each { |dependency| require dependency }

configure do
	PageTitle = "Search Twitter for "
	Hat = 'hat.gif'
	Credits = 'Powered by <a href=/sinatra>Sinatra</a> and <a href=/twitter>Twitter</a>'

	# %23 is the hash # symbol, %3A is the @ symbol
	TwitterHashSearch = "http://search.twitter.com/search.atom?q=%23"
	TwitterAtmarkSearch = "http://search.twitter.com/search.atom?q=%3A"
end

get '/' do
	haml :howto
end

get '/@:tag' do |t|
	headers 'Content-Type' => 'text/html; charset=utf-8'
	res = FeedParser.parse(TwitterAtmarkSearch + t)
	@entries = res.entries
	haml :atmark
end

get '/:tag' do |t|
	headers 'Content-Type' => 'text/html; charset=utf-8'
	res = FeedParser.parse(TwitterHashSearch + t)
	@entries = res.entries
	haml :hash
end

