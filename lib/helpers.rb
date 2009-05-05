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

end
