# frozen_string_literal: true
require 'rest-client'
require_relative 'spotify_playlist/version'
require_relative 'spotify_playlist/auth'
require_relative 'spotify_playlist/playlist'
require_relative 'spotify_playlist/track'
require_relative 'spotify_playlist/credentials_manager'
require_relative 'spotify_playlist/repository'
require_relative 'spotify_playlist/parser'

begin
  username, pwd = CredentialsManager.get_credentials("#{__dir__}/spotify_playlist/credentials.txt")
rescue SystemCallError => e
  puts e.message
  exit
end
auth = Auth.new(username, pwd)
begin
  access_token = auth.authorize
rescue RuntimeError => e
  puts e.message
  exit
end
repo = Repository.new(access_token)
user_id = repo.user_id
playlist = repo.create_playlist(user_id)
# Add 3 tracks to the created playlist
# 1. Coldplay - Fix you, 2. Seether - The Gift, 3. Nickelback - Far Away
tracks = ['spotify:track:7clUVcSOtkNWa58Gw5RfD4',
          'spotify:track:5Vo2JtJMOozIKC7y37HLv8',
          'spotify:track:0ADZ5dmXhlfzjMw6lefoPl']
repo.add_tracks_to_playlist(playlist['id'], tracks)
repo.put_first_track_to_end(playlist['id'])
repo.delete_last_track(playlist['id'])
playlist_from_spotify = repo.get_playlist(playlist['id'])

tracks_to_add = Parser.get_tracks(playlist_from_spotify)

playlist_obj = Playlist.new(
  playlist_from_spotify['id'],
  playlist_from_spotify['name'],
  playlist_from_spotify['description'],
  playlist_from_spotify['owner']['display_name'],
  playlist_from_spotify['href'],
  tracks_to_add
)

puts playlist_obj.to_json
