class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @item = Item.find(params[:item_id])
    @orderaddress = OrderAddress.new
  end

  def create
    @orderaddress = OrderAddress.new(order_params)
    if @orderaddress.valid?
      @orderaddress.save(params, current_user.id)
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postalcode, :prefecture, :municipalities, :street_address, :building_name,
                                          :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end
