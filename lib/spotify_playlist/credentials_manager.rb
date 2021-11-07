module SpotifyPlaylist
  class CredentialsManager
    def self.get_credentials(filepath)
      username = ''
      pwd = ''
      begin
        File.open(filepath, 'r') do |f|
          username = f.readline.strip
          pwd = f.readline.strip
        end
      rescue SystemCallError
        raise 'Can\'t find or open credentials.txt using this path'
      end
      [username, pwd]
    end
  end
end
