class CredentialsManager
  def self.get_credentials(filepath)
    username = ''
    pwd = ''
    begin
      File.open(filepath, 'r') do |f|
        username = f.readline
        pwd = f.readline
      end
    rescue SystemCallError => e
      puts e.message
      exit
    end

    [username, pwd]
  end
end