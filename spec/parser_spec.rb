require_relative '../lib/spotify_playlist/parser'
require 'json'

RSpec.describe Parser do
  let(:playlist) { JSON.parse(File.read('spec/fixtures/playlist.json')) }

  context '.get_tracks' do
    it 'returns array with 2 items' do
      expect(Parser.get_tracks(playlist).count).to eq(2)
    end
    it 'returns an array that contains Track objects' do
      expect(Parser.get_tracks(playlist)[0].class).to eq(Track)
    end
  end
end
