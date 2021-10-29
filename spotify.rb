require './lib/auth.rb'
require './lib/playlist.rb'
require './lib/track.rb'
require 'rest-client'

SCOPE = 'playlist-modify-private playlist-read-private'
USER_ID = '31xkrm6kuqiy63qenzsgscusueyu'

auth = Auth.new(SCOPE, 'llsultanovall@gmail.com', 'sultanovaspotify')
code = auth.authorize
access_token = auth.get_token(code)
headers = { content_type: 'application/json', authorization: "Bearer #{access_token}" }

# Create a playlist
create_playlist_endpoint = "https://api.spotify.com/v1/users/#{USER_ID}/playlists"
begin
  playlist_json = RestClient.post(
    create_playlist_endpoint,
    JSON.dump({ name: 'New cool playlist', public: 'false', description: 'Created by a script' }),
    headers
  )
rescue RestClient::Exception => e
  puts e.response
  exit
end
playlist = JSON.parse(playlist_json)

# Add 3 tracks to the created playlist
add_tracks_endpoint = "https://api.spotify.com/v1/playlists/#{playlist['id']}/tracks"
tracks = ['spotify:track:7clUVcSOtkNWa58Gw5RfD4',
          'spotify:track:5Vo2JtJMOozIKC7y37HLv8',
          'spotify:track:0ADZ5dmXhlfzjMw6lefoPl']

begin
  RestClient.post(
    add_tracks_endpoint,
    JSON.dump(tracks),
    headers
  )
rescue RestClient::Exception => e
  puts e.response
  exit
end

# Put the first track to the end
reorder_tracks_endpoint = "https://api.spotify.com/v1/playlists/#{playlist['id']}/tracks"
begin
  RestClient.put(
    reorder_tracks_endpoint,
    JSON.dump({ range_start: 0, insert_before: tracks.length }),
    headers
  )
rescue RestClient::Exception => e
  puts e.response
  exit
end

# Delete the last track from the playlist
delete_tracks_endpoint = "https://api.spotify.com/v1/playlists/#{playlist['id']}/tracks"
begin
  RestClient::Request.execute(method: :delete,
                              url: delete_tracks_endpoint,
                              payload: JSON.dump({ tracks: Array.new(1, { uri: tracks[0] }) }),
                              headers: headers)
rescue RestClient::Exception => e
  puts e.response
  exit
end

# Get that playlist back from Spotify
get_playlist_endpoint = "https://api.spotify.com/v1/playlists/#{playlist['id']}"
begin
  playlist_from_spotify_json = RestClient.get(
    get_playlist_endpoint,
    headers
  )
rescue RestClient::Exception => e
  puts e.response
  exit
end
playlist_from_spotify = JSON.parse(playlist_from_spotify_json)
tracks_to_add = playlist_from_spotify['tracks']['items'].map do |track|
  track = track['track']
  artists = track['artists'].map do |artist|
    artist['name']
  end
  Track.new(track['id'], track['name'], artists.join(','), track['album']['name'], track['href'])
end

playlist_obj = Playlist.new(
                            playlist_from_spotify['id'],
                            playlist_from_spotify['name'],
                            playlist_from_spotify['description'],
                            playlist_from_spotify['owner']['display_name'],
                            playlist_from_spotify['href'],
                            tracks_to_add
)

puts playlist_obj.to_json