# frozen_string_literal: true

RSpec.describe SpotifyPlaylist do
  it "has a version number" do
    expect(SpotifyPlaylist::VERSION).not_to be nil
  end
end
