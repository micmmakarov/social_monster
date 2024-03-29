class HomeController < ApplicationController

  before_filter :authenticate_user!, :only => :announce

  def announce
    @api = Koala::Facebook::API.new(current_user.access_code)
  end

  def index
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/home/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream, email, publish_stream")
    puts session.to_s + "<<< session"

    respond_to do |format|
      format.html {  }
    end
  end

  def callback

    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
      @api = Koala::Facebook::API.new(session[:access_token])
      fb_me = @api.get_object("me")
      @user = User.oauth_user(fb_me, session[:access_token])
      if @user
        sign_in(@user)
      end
    end

    # auth established, now do a graph call:

    begin
      @graph_data = @api.get_object("/me/statuses", "fields"=>"message")
    rescue Exception=>ex
      puts ex.message
    end


    respond_to do |format|
      format.html {   }
    end

  end





end
