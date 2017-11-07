class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(buyer: current_user)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.product = Product.find(params[:product_id])
    @amount = @order.product.price_cents + @order.product.postage_cents
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.buyer = current_user
    @order.product = Product.find(order_params[:product_id])
    # Amount in cents
    @amount = @order.product.price_cents + @order.product.postage_cents

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @order.product.title,
      :currency    => 'aud'
    )

    @order.charge_identifier = charge.id

    @order.save

    buyer_email = current_user.email
    order_details = {
        title: @order.product.title,
        artist: @order.product.artist,
        total_amount: @amount
      }

      OrderMailer.order_confirmation(buyer_email, order_details).deliver_now

      redirect_to orders_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_path(product_id: @order.product.id)
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:product_id)
    end
end
