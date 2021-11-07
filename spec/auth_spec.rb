# frozen_string_literal: true

require_relative '../lib/spotify_playlist/auth'

RSpec.describe Auth do
  context 'given incorrect username or password' do
    it 'raises an exception with message: "Incorrect username or password."' do
      auth = Auth.new('wrong_username', 'wrong_password')
      expect { auth.authorize }.to raise_exception('Incorrect username or password.')
    end
  end
end
