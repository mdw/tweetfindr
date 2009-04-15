# helpers.rb - all my helpers are belong to here

module Helpers

     def link_to(url, title, klass, inner)
        '<a href="' + url + '" title="' + title + '" class="' + klass + '">' + inner + "</a>"
     end

     def termlink(hashtag)
        url = "http://" + request.host + '/' + hashtag
        title = 'search for #' + hashtag
        link_to(url, title, "hash", '#'+hashtag)
     end

     def peoplelink(username)
        if request.host == 'localhost'
           url = "http://" + request.host + ":#{request.port}/@#{username}"
        else
           url = "http://tweetfindr.com/@#{username}"
        end
        title = 'search for @' + username 
        link_to(url, title, "people", '@'+username)
     end
end
