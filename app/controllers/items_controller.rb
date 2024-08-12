class ItemsController < ApplicationController
  before_action :move_to_signin, except: :index

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :text, :category_id, :condition_id, :shipping_id, :prefecture_id, :delivery_time_id,
                                 :price).merge(user_id: current_user.id)
  end

  def move_to_signin
    return if user_signed_in?

    redirect_to new_user_session_path
  end
end
