require_relative 'track'

class Parser
  def self.get_tracks(playlist_json)
    playlist_json['tracks']['items'].map do |track|
      track = track['track']
      artists = track['artists'].map do |artist|
        artist['name']
      end
      Track.new(track['id'], track['name'], artists.join(','), track['album']['name'], track['href'])
    end
  end
end
