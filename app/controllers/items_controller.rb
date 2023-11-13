class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to '/'
  end  

  private

  def item_params
    params.require(:item).permit(:title, :detail, :image, :price, :category_id, :condition_id, :shipcost_id, :place_id,
                                 :shipdate_id).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?
    redirect_to new_user_session_path
  end

  def set_item
    @item = Item.find(params[:id])
  end  

  def contributor_confirmation
    redirect_to '/' unless current_user == @item.user
    if current_user == @item.user && @item.order.present?
      redirect_to root_path
    end
  end
end
