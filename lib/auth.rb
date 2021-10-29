require 'watir'
require 'rest-client'
require 'json'

# Class that does all the authentication steps
class Auth
  CLIENT_ID = 'b174e95d76534e5a85a6055f76371c3e'
  CLIENT_SECRET = '093442b2cf414d04ba2d44d2b2980796'
  REDIRECT_URI = 'https://developer.spotify.com'

  def initialize(scope, username, pwd)
    @scope = scope
    @username = username
    @pwd = pwd
  end

  def authorize
    browser = Watir::Browser.new :firefox
    url = build_url
    browser.goto url
    browser.input(id: 'login-username').send_keys(@username)
    browser.input(id: 'login-password').send_keys(@pwd)
    browser.button(id: 'login-button').click
    browser.wait_until { |b| b.title == 'Home | Spotify for Developers' }
    url_after_redirect = browser.url
    code_start_index = url_after_redirect.index('=') + 1
    # Get the code from the URL and return it
    url_after_redirect[code_start_index..-1]

  end

  def get_token(code)
    begin
      response_json = RestClient.post('https://accounts.spotify.com/api/token',
                                      { code: code, grant_type: 'authorization_code', redirect_uri: REDIRECT_URI },
                                      { content_type: 'application/x-www-form-urlencoded',
                                        authorization: 'Basic ' + Base64.strict_encode64(CLIENT_ID + ':' + CLIENT_SECRET)})
    rescue RestClient::Exception => e
      puts e.response
    end

    response = JSON.parse(response_json)
    response['access_token']
  end

  private

  def build_url
    endpoint = 'https://accounts.spotify.com/authorize'
    querystring = "?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{REDIRECT_URI}&scope=#{@scope}"
    endpoint + querystring
  end
end
