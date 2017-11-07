class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:query]
      @products = Product.search(params[:query]).page(params[:page]).per(50)
    elsif params[:filter_by]
      @products = Product.filter(params[:filter_by]).page(params[:page]).per(50)
    else
      @products = Product.all.order_products(params[:sort_by]).page(params[:page]).per(50)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if current_user.present?
      @active_conversation = Conversation.find_by(buyer_id: current_user.id, seller_id: @product.user_id)
    end

    discogs = @product.discogs_id

    discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
    discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')

    response = HTTParty.get("https://api.discogs.com/releases/#{discogs}?&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

    @release_data = response
    @amount = @product.price_cents + @product.postage_cents
  end

  # GET /products/new
  def new
    @product = Product.new

    # save user query to perform api call
    query = params[:query]

    # if query is present perform api call
    if query
      discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
      discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')

      # perform search for query and limit to vinyl
      response = HTTParty.get("https://api.discogs.com/database/search?release_title=\"#{query}\"&format=vinyl&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

      # return results array as instance variable
      @release_data = response['results']
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    # convert user input for price to cents/integer
    price = product_params[:price_cents]
    price_in_cents = Product.convert_to_cents(price)
    @product.price_cents = price_in_cents

    # convert user input for postage to cents/integer
    postage = product_params[:postage_cents]
    postage_in_cents = Product.convert_to_cents(postage)
    @product.postage_cents = postage_in_cents

    discogs = @product.discogs_id

    discogs_api_key = ENV.fetch('DISCOGS_API_KEY')
    discogs_secret_api_key = ENV.fetch('DISCOGS_SECRET_API_KEY')

    # Search discogs to retrive release title
    response = HTTParty.get("https://api.discogs.com/releases/#{discogs}?&key=#{discogs_api_key}&secret=#{discogs_secret_api_key}")

    @product.title = response['title']
    @product.artist = response['artists'][0]['name']
    # byebug
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:price_cents, :postage_cents, :record_condition, :sleeve_condition, :discogs_id, :description)
    end
end
