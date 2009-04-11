# helpers.rb - all my helpers are belong to here

module Helpers

   def link_to(url, title, klass, inner)
      '<a href="' + url + '" title="' + title + '" class="' + klass + '">' + inner + '</a>'
   end

   def termlink(hashtag)
      url = "http://" + request.host + '/' + hashtag
      title = 'search for #' + hashtag
      inner = '#' + hashtag
      link_to(url, title, "hash", '#'+hashtag)
   end

   def peoplelink(username)
      url = "http://" + request.host + '/@' + username
      title = 'search for @' + username
      link_to(url, title, "people", '@'+username)
   end
end
