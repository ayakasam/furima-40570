class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_item, only: [:index, :create]
  def index
    if user_signed_in? && @item.user != current_user && @item.order.blank?
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @orderaddress = OrderAddress.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @orderaddress = OrderAddress.new(order_params)
    if @orderaddress.valid?
      pay_item
      @orderaddress.save(params, current_user.id)
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      set_item
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postalcode, :prefecture_id, :municipalities, :street_address, :building_name,
                                          :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token]) # rubocop:disable Layout/LineLength
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
