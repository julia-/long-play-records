class ReleasesController < ApplicationController
  before_action :set_artist
  before_action :set_release, only: [:show, :edit, :update, :destroy]

  # GET /releases
  # GET /releases.json
  def index
    query = params[:query]
    artist_name = @artist.name

    database_search = Release.search_database_release(query, artist)

    if !database_search.empty?
      database_search
    else
      discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
      discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')

      response = HTTParty.get("https://api.discogs.com/database/search?release_title=#{query}&artist=#{artist}&format=vinyl&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

      @release_data = response['results']
  end

  # GET /releases/1
  # GET /releases/1.json
  def show
  end

  # GET /releases/new
  def new
    @release = Release.new
  end

  # GET /releases/1/edit
  def edit
  end

  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(release_params)

    # release_title = release_params[:title]
    # artist_name = @artist.name
    #
    # discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
    # discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')
    #
    # response = HTTParty.get("https://api.discogs.com/database/search?release_title=#{release_title}&artist=#{artist_name}&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

    # byebug

    response['results'].each do |result|
      if result['format'].include? "Vinyl"
        @release.artist_id = @artist

        release_title = response['title'].split(' - ').last
        @release.title = release_title

        format_array = response['format'].split(' ')
        format_type = format_array.select { |format| format == "LP" }
        @release.format = format_type.join

        @release.released_at = response['year']
        @release.image_data = response['images'][0]['resource_url']
        @release.country_code = response['id']
        @release.format = response['id']
        @release.artist_id = response['id']
      end
    end

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /releases/1
  # PATCH/PUT /releases/1.json
  def update
    respond_to do |format|
      if @release.update(release_params)
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'Release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find(params[:id])
    end

    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_params
      params.require(:release).permit(:title, :catalogue_number, :format, :country_code, :released_at, :image_data, :artist_id, :query)
    end
end
