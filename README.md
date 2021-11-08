# SpotifyPlaylist

## Usage
Before running the script make sure you have firefox installed and geckodriver placed in one of the folders in $PATH.  
You can download the latest version of geckodriver from: https://github.com/mozilla/geckodriver/releases  

SpotifyPlaylist takes your credentials from lib/credentials.txt.
Put your username and password there separated by a new line:  
username  
password

## How to run tests
Go to the root directory and run rspec:
```
max@max-LIFEBOOK-E756:~/RubymineProjects/SpotifyPlaylist/spotify_playlist$ rspec
```

## How to run the script
To run the script go to the project's root directory and do: ruby lib/spotify_playlist.rb  
```
max@max-LIFEBOOK-E756:~/RubymineProjects/SpotifyPlaylist/spotify_playlist$ ruby lib/spotify_playlist
```

## Output
SpotifyPlaylist outputs the playlist stored as JSON to the console.  
Example:  
```
tsltnv@MacBook-Pro-Tatana spotifyPlaylist-master % ruby lib/spotify_playlist.rb             
{
  "id": "0ciUJVWT1ZbhOOppG4ptI9",
  "name": "New cool playlist",
  "description": "Created by a script",
  "owner_name": "Татьяна Султанова",
  "spotify_url": "https://api.spotify.com/v1/playlists/0ciUJVWT1ZbhOOppG4ptI9",
  "tracks": [
    {
      "id": "5Vo2JtJMOozIKC7y37HLv8",
      "name": "The Gift",
      "artist_name": "Seether",
      "album_name": "Karma and Effect",
      "spotify_url": "https://api.spotify.com/v1/tracks/5Vo2JtJMOozIKC7y37HLv8"
    },
    {
      "id": "0ADZ5dmXhlfzjMw6lefoPl",
      "name": "Far Away",
      "artist_name": "Nickelback",
      "album_name": "All the Right Reasons",
      "spotify_url": "https://api.spotify.com/v1/tracks/0ADZ5dmXhlfzjMw6lefoPl"
    }
  ]
}
```
