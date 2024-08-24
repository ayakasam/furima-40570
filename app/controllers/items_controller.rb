class ItemsController < ApplicationController
  before_action :move_to_signin, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
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

  def show
  end

  def edit
    if @item.user == current_user && @item.order.blank?
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(params[:id])
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

  def set_item
    @item = Item.find(params[:id])
  end
end
