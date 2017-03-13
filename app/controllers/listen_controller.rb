class ListenController < ApplicationController
  def index
    @spotify_user = false
    @playlist_data = false
    @playlist = false

    if session[:spotify_user]
      @spotify_user = RSpotify::User.new(session[:spotify_user])
      playlist_param = Hash.new
      playlist_param['user'] = @spotify_user.id
      playlist_param['playlist_id'] = @spotify_user.playlists.third.id

      @playlist_param = Base64.encode64(playlist_param.to_json)

      @playlists = Array.new
      @spotify_user.playlists(limit: 50).each do |playlist|
        @playlists.push(
          {
            'name' => playlist.name,
            'link' => '/?p=' + Base64.encode64(
              {
                'user' => @spotify_user.id,
                'playlist_id' => playlist.id
              }.to_json
            )
          }
        )
      end
    end

    if params[:p]
      playlist_json = Base64.decode64(params[:p])
      if playlist_json
        @playlist_data = JSON.parse(playlist_json)
        if @playlist_data
          begin
            @playlist = RSpotify::Playlist.find(@playlist_data['user'], @playlist_data['playlist_id'])
          rescue => ex
            logger.error ex.message
            logger.error @playlist_data['playlist_id']
          end
        end
      end
    end
  end
end
