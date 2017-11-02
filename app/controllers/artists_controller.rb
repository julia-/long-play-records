class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  # GET /artists
  # GET /artists.json
  def index
    @artist = Artist.new
    @artists = Artist.all
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)

    artist_name = artist_params[:name]

    discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
    discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')

    search_response = HTTParty.get("https://api.discogs.com/database/search?q=#{artist_name}&?artist&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

    discog_id = search_response['results'][0]['id']

    response = HTTParty.get("https://api.discogs.com/artists/#{discog_id}?&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

    @artist.name = response['name']
    @artist.biography = response['profile']
    @artist.image_data = response['images'][0]['resource_url']
    @artist.discog_number = response['id']

    response['members'].each do |member|
      name_array = member['name'].split(' ')
      first_name = name_array[0]
      last_name = name_array[1]
      Member.create! first_name: first_name, last_name: last_name
    end

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name, :biography, :image, :discog_number)
    end
end
