require "./lib/auth.rb"
SCOPE = 'playlist-modify-private playlist-read-private'

auth = Auth.new(SCOPE, 'llsultanovall@gmail.com', 'sultanovaspotify')
code = auth.authorize
access_token = auth.get_tokens(code)
puts access_token
