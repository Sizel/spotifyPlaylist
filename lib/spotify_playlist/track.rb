# frozen_string_literal: true

class Track
  attr_accessor :id, :name, :artist_name, :album_name, :spotify_url

  def initialize(id, name, artist_name, album_name, spotify_url)
    @id = id
    @name = name
    @artist_name = artist_name
    @album_name = album_name
    @spotify_url = spotify_url
  end

  def as_json(_={})
    {
      id: @id,
      name: @name,
      artist_name: @artist_name,
      album_name: @album_name,
      spotify_url: @spotify_url
    }
  end

  def to_json(*options)
    JSON.pretty_generate(as_json(*options), *options)
  end
end
