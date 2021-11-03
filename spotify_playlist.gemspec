# frozen_string_literal: true

require_relative "lib/spotify_playlist/version"

Gem::Specification.new do |spec|
  spec.name          = "spotify_playlist"
  spec.version       = SpotifyPlaylist::VERSION
  spec.authors       = ["sizel"]
  spec.email         = ["xsizelx@gmail.com"]

  spec.summary       = "App that connects to your Spotify account, creates a playlist and makes some changes to it"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "rubygems.org"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rest-client", "~> 2.1.0"
  spec.add_dependency "watir", "~> 7.0.0"
  spec.add_development_dependency "rspec", "~> 3.10"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
