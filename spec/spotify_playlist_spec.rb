# frozen_string_literal: true
require_relative '../lib/spotify_playlist/version'

RSpec.describe SpotifyPlaylist do
  it "has a version number" do
    expect(SpotifyPlaylist::VERSION).not_to be nil
  end
end
