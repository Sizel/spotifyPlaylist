# frozen_string_literal: true

class CredentialsManager
  def self.get_credentials(filepath)
    username = ''
    pwd = ''
    File.open(filepath, 'r') do |f|
      username = f.readline.strip
      pwd = f.readline.strip
    end
    [username, pwd]
  end
end
