# helpers.rb - all my helpers are belong to here

module Helpers

     def link_to(url, title, klass, inner)
        '<a href="' + url + '" title="' + title + '" class="' + klass + '">' + inner + '</a>'
     end

     def termlink(hashtag)
        url = "/#{hashtag}"
        title = 'search for #' + hashtag
        link_to(url, title, "hash", '#'+hashtag)
     end

     def peoplelink(username)
        url = "/@#{username}"
        title = 'search for @' + username 
        link_to(url, title, "people", '@'+username)
     end
end
