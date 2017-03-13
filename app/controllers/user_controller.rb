class UserController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    session[:spotify_user] = spotify_user.to_hash

    redirect_to root_url
  end
end
