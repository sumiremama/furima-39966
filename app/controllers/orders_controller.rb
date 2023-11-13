class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end
  
  def create
    @order_address = OrderAddress.new(order_address_params)
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postcode, :place_id, :city, :blocknum, :apartment, :phone).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end  

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item[:price],
        card: order_address_params[:token],
        currency: 'jpy'
      )
  end
end
