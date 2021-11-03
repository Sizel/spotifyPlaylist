# frozen_string_literal: true

require_relative 'spotify_playlist/version'
require 'rest-client'
require 'spotify_playlist/auth'
require 'spotify_playlist/playlist'
require 'spotify_playlist/track'
require 'spotify_playlist/credentials_manager'
require 'spotify_playlist/repository'

# Module that has only "run" method to run the script
module SpotifyPlaylist
  class Error < StandardError; end

  def run
    username, pwd = CredentialsManager.get_credentials("#{__dir__}/credentials.txt")
    auth = Auth.new(username, pwd)
    access_token = auth.authorize

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
  end
end
