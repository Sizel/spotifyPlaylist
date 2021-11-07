require_relative '../lib/spotify_playlist/credentials_manager'

RSpec.describe SpotifyPlaylist::CredentialsManager do
  context 'no file given' do
    it 'outputs to the console that there is no credentials.txt file' do
      expect { subject.get_credentials('/home/sizel') }.to raise_exception('Can\'t find or open credentials.txt using this path')
    end
  end
end