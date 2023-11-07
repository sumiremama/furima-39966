class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :ensure_current_user, only: [:edit, :update]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
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

  def ensure_current_user
    item = Item.find(params[:id])
    return unless item.user_id != current_user.id

    redirect_to action: :index
  end
end
