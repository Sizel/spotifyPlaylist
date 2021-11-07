require 'watir'
require 'rest-client'
require 'json'

module SpotifyPlaylist
# Class that does all the authentication steps
  class Auth
    CLIENT_ID = 'b174e95d76534e5a85a6055f76371c3e'
    CLIENT_SECRET = '093442b2cf414d04ba2d44d2b2980796'
    SCOPE = 'playlist-modify-private playlist-read-private user-read-private user-read-email'
    REDIRECT_URI = 'https://developer.spotify.com'

    def initialize(username, pwd)
      @username = username
      @pwd = pwd
    end

    def authorize
      url_after_redirect = login
      get_token(get_code_from_url(url_after_redirect))
    end

    private

    def login
      browser = Watir::Browser.new :firefox
      browser.goto(auth_url)
      browser.input(id: 'login-username').set(@username)
      browser.input(id: 'login-password').set(@pwd)
      browser.button(id: 'login-button').click

      error = check_for_error(browser)

      unless error.nil?
        browser.close
        raise error
      end

      sleep(2)
      browser.button(id: 'auth-accept').click if browser.title == 'Authorize - Spotify'
      browser.wait_until { |b| b.title == 'Home | Spotify for Developers' }
      browser.url
    end

    def check_for_error(browser)
      alert = browser.p(class: 'alert-warning').span
      begin
        alert.wait_until(timeout: 3, &:present?)
        alert.inner_html
      rescue Watir::Wait::TimeoutError
        nil
      end
    end

    def get_token(code)
      begin
        response_json = RestClient.post('https://accounts.spotify.com/api/token',
                                        { code: code, grant_type: 'authorization_code', redirect_uri: REDIRECT_URI },
                                        { content_type: 'application/x-www-form-urlencoded',
                                          authorization: "Basic #{Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")}" })
      rescue RestClient::Exception => e
        puts e.response
      end

      response = JSON.parse(response_json)
      response['access_token']
    end

    def auth_url
      endpoint = 'https://accounts.spotify.com/authorize'
      querystring = "?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{REDIRECT_URI}&scope=#{SCOPE}"
      endpoint + querystring
    end

    def get_code_from_url(url)
      code_start_index = url.index('=') + 1
      url[code_start_index..]
    end
  end
end
