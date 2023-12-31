require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入記録の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
      sleep 0.5
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'apartmentは空でも保存できる' do
        @order_address.apartment = ''
        expect(@order_address).to be_valid
      end
      it 'postcodeが「3桁ハイフン4桁」の半角数字であれば保存できる' do
        @order_address.postcode = '123-4567'
        expect(@order_address).to be_valid
      end
      it 'phoneが10桁以上11桁以内の半角数値であれば保存できる' do
        @order_address.phone = '09012345678'
        expect(@order_address).to be_valid
      end
    end
    
    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できない' do
        @order_address.postcode = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeは「3桁ハイフン4桁」の半角数字でなければ保存できない' do
        @order_address.postcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it 'place_idが空だと保存できない' do
        @order_address.place_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Place can't be blank")
      end
      it 'place_idは---を選択すると保存できない' do
        @order_address.place_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages)
      end
      it 'cityが空だと保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'blocknumが空だと保存できない' do
        @order_address.blocknum = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Blocknum can't be blank")
      end
      it 'phoneが空だと保存できない' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneに半角数字以外が含まれていると保存できない' do
        @order_address.phone = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid.")
      end
      it 'phoneが9桁以下では保存できない' do
        @order_address.phone = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid.")
      end
      it 'phoneが12桁以上では保存できない' do
        @order_address.phone = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is too long (maximum is 11 characters)")
      end
      it 'tokenが空だと保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end  
end
