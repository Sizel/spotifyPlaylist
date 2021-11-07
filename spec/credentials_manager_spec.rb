require_relative '../lib/spotify_playlist/credentials_manager'

RSpec.describe CredentialsManager do
  before(:all) do
    File.rename('lib/credentials.txt', 'lib/x.txt') if File.file?('lib/credentials.txt')
  end

  after(:all) do
    File.rename('lib/x.txt', 'lib/credentials.txt') if File.file?('lib/x.txt')
  end
  context 'given no credentials.txt in /lib directory' do
    it 'raises SystemCallError exception' do
      expect { CredentialsManager.get_credentials('lib/credentials.txt') }.to raise_error SystemCallError
    end
  end
end
