class OrdersController < ApplicationController
  before_action :set_order, only: %i[show]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @products = Product.where(id: @order.order_details.keys) unless @order.nil?
  end

  # POST /orders
  # POST /orders.json
  def create
    order_details = {}
    total_price = 0
    if params[:order_details].as_json.is_a?(Hash)
      params[:order_details].each_pair do |key, value|
        order_details[key.to_i] = value.to_i
        total_price += Product.find(key.to_i).price * value.to_i if Product.exists?(key.to_i)
      end
    end

    @order = Order.new(user_id: current_user.id, order_details: order_details, total_price: total_price)
    respond_to do |format|
      if @order.save
        # Get all products in order, then send an email to user
        @products = Product.where(id: @order.order_details.keys)
        OrderNotifier.send_order_notifier(current_user, @order, @products).deliver
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :index }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = current_user.orders.find params[:id] if current_user.orders.exists? params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def order_params
  #   params.require(:order).permit(params[:order_details])
  # end
end
