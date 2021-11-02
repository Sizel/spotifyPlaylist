class Repository
  def initialize(access_token)
    @token = access_token
    @headers = { content_type: 'application/json', authorization: "Bearer #{access_token}" }
  end

  def user_id
    get_user_info_endpoint = 'https://api.spotify.com/v1/me'
    begin
      user_info_json = RestClient.get(
        get_user_info_endpoint,
        @headers
      )
    rescue RestClient::Exception => e
      puts e.response
      exit
    end
    JSON.parse(user_info_json)['id']
  end

  def create_playlist(user_id)
    create_playlist_endpoint = "https://api.spotify.com/v1/users/#{user_id}/playlists"
    begin
      playlist_json = RestClient.post(
        create_playlist_endpoint,
        JSON.dump({ name: 'New cool playlist', public: 'false', description: 'Created by a script' }),
        @headers
      )
    rescue RestClient::Exception => e
      puts e.response
      exit
    end
    JSON.parse(playlist_json)
  end

  def add_tracks_to_playlist(playlist_id, tracks)
    add_tracks_endpoint = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
    begin
      RestClient.post(
        add_tracks_endpoint,
        JSON.dump(tracks),
        @headers
      )
    rescue RestClient::Exception => e
      puts e.response
      exit
    end
  end

  def put_first_track_to_end(playlist_id)
    reorder_tracks_endpoint = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
    playlist = get_playlist(playlist_id)
    total_tracks = playlist['tracks']['total']
    begin
      RestClient.put(
        reorder_tracks_endpoint,
        JSON.dump({ range_start: 0, insert_before: total_tracks}),
        @headers
      )
    rescue RestClient::Exception => e
      puts e.response
      exit
    end
  end

  def delete_last_track(playlist_id)
    delete_tracks_endpoint = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
    playlist = get_playlist(playlist_id)
    last_track_id = playlist['tracks']['items'].last['track']['id']
    begin
      RestClient::Request.execute(method: :delete,
                                  url: delete_tracks_endpoint,
                                  payload: JSON.dump({ tracks: Array.new(1, { uri: "spotify:track:#{last_track_id}" }) }),
                                  headers: @headers)
    rescue RestClient::Exception => e
      puts e.response
      exit
    end
  end

  def get_playlist(playlist_id)
    get_playlist_endpoint = "https://api.spotify.com/v1/playlists/#{playlist_id}"
    begin
      playlist_from_spotify_json = RestClient.get(
        get_playlist_endpoint,
        @headers
      )
    rescue RestClient::Exception => e
      puts e.response
      exit
    end
    JSON.parse(playlist_from_spotify_json)
  end
end