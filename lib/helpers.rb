# helpers.rb - all my helpers are belong to here

module Helpers

     def link_to(url, title, klass, inner)
        '<a href="' + url + '" title="' + title + '" class="' + klass + '">' + inner + '</a>'
     end

     def termlink(hashtag)
        url = "http://" + request.host + '/' + hashtag
        title = 'search for #' + hashtag
        link_to(url, title, "hash", '#'+hashtag)
     end

     def peoplelink(username)
        # why does the request.host fail to have portnum here when it works in above method?
        #url = "http://" + request.host + '/@' + username 
        url = "http://" + request.host
        url << ":#{request.port}" unless request.port.nil?
        url << "/@#{username}"
        title = 'search for @' + username
        link_to(url, title, "people", '@'+username)
     end
end
