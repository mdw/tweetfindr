# helpers.rb - all my helpers are belong to here

module Helpers

     # we write lotsa links
     def link_to_home
        img = '<img src="/hat.gif" alt="Frankie Baby" class="mainpic" border="0"/>'
        '<a href="/" title="Powered by Sinatra and Twitter">' + img + '</a>'
     end

     def termlink(hashtag)
        url = "/#{hashtag}"
        title = 'search for #' + hashtag
        '<a href="' + url + '" title="' + title + '" class="hash">#' + hashtag + '</a>'
     end

     def peoplelink(username)
        url = "/@#{username}"
        title = 'search for @' + username 
        '<a href="' + url + '" title="' + title + '" class="people">@' + username + '</a>'
     end

     def link_to_client( clientname, href, img )
        image = '<img src="' + img + '" alt="' + clientname + '" border="0"/>'
        '<a href="' + href + '" title="' + clientname + '">' + image + '</a>'
     end

     # lookup twitter client info from YAML file
     def get_icon(clientname)
        @icons.each do |i| 
          @sysmessage = i.icon if i.client == clientname.downcase
          @ticon = i.icon if i.client == clientname.downcase
        end
        return @ticon
     end

     def tweetclient_icon( client )
        #path = File.join(File.join(ENV['HOME'], "config"), "tweetclients.yml")
        path = "./config/tweetclients.yml"
        clientlist = YAML::load_file(path)
        iconfile = clientlist[client]['icon'] || "twitterrific.png"
        "/icons" + iconfile 
     end

end
