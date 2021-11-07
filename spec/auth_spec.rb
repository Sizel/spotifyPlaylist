require_relative '../lib/spotify_playlist'

RSpec.describe SpotifyPlaylist::Auth do
  context 'given incorrect username or password' do
    it 'outputs to console that credentials are wrong' do
      auth = SpotifyPlaylist::Auth.new('wrong_username', 'wrong_password')
      expect { auth.authorize }.to raise_exception('Incorrect username or password.')
    end
  end
end
