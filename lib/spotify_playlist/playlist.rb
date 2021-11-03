module SpotifyPlaylist
  class Playlist
    attr_accessor :id, :name, :description, :owner_name, :spotify_url, :tracks
  
    def initialize(id, name, description, owner_name, spotify_url, tracks)
      @id = id
      @name = name
      @description = description
      @owner_name = owner_name
      @spotify_url = spotify_url
      @tracks = tracks
    end
  
    def as_json(_={})
      {
        id: @id,
        name: @name,
        description: @description,
        owner_name: @owner_name,
        spotify_url: @spotify_url,
        tracks: @tracks
      }
    end
  
    def to_json(*options)
      JSON.pretty_generate(as_json(*options))
    end
  end
end
