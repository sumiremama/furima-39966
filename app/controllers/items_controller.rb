class ItemsController < ApplicationController
  # before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :show]

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

  private

  def item_params
    params.require(:item).permit(:title, :detail, :image, :price, :category_id, :condition_id, :shipcost_id, :place_id,
                                 :shipdate_id).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?

    redirect_to new_user_session_path
  end
end
