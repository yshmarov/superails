class ArtistsController < ApplicationController
  def search
  end  

  def get_podcasts
    api_key = TELEGRAM
    # chat_id = -572374068
    # chat_id = 450462613
    chat_id = session[:user_id]
    text = "I am feeling great today"
    # HTTParty.post("https://api.telegram.org/bot#{api_key}/sendMessage?chat_id=#{chat_id}&text=#{text}")

x = HTTParty.get("https://api.spotify.com/v1/shows",
  body: {
    'client_id' => '8f84292ed3a24d4b86cdce0ff190a365',
    'client_secret' => 'dbeb3aecc71c414689914d89a23fb223',
})


    results = HTTParty.get("http://some.api", :headers => {
      "Authorization" => "Bearer #{response.access_token}"
    })

@sp_access = HTTParty.post('https://accounts.spotify.com/api/token',
                           headers: { 'Accept' => 'application/json' },
                           body: {
                             'client_id' => '8f84292ed3a24d4b86cdce0ff190a365',
                             'client_secret' => 'dbeb3aecc71c414689914d89a23fb223',
                             'grant_type' => 'authorization_code',
                             'redirect_uri' => 'https://into-api.herokuapp.com/callback'
                           })
@sp_access_token = @sp_access['access_token']
@sp_data = HTTParty.get('https://api.spotify.com/v1/me',
                        headers: { 'Authorization' => "Bearer #{@sp_access_token}", 'Accept' => 'application/json' })
@sp_user_email = @sp_data['email']

    HTTParty.post("https://api.telegram.org/bot#{api_key}/sendMessage",
      headers: {
        'Content-Type' => 'application/json'
      },
      body: {
        chat_id: chat_id,
        text: text
      }.to_json
    )

    redirect_to root_path, notice: "success"
  end

  def index
    if !params[:artist_name].empty?
      @artists = RSpotify::Show.search(params[:artist_name])
    else
      redirect_to root_path
    end
  end

  def show
    @artist = RSpotify::Show.find(params[:id])
  end
end
