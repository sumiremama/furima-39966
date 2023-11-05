require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '出品できる場合' do
      it "image, title, detail, category_id, condition_id, shipcost_id, place_id, shipdate_id, priceが存在すれば出品できる" do
        expect(@item).to be_valid
      end

      it 'imageが1枚存在すれば出品できる' do
        image_path = Rails.root.join('public/images/test_image.png')
        @item.image.attach(io: File.open(image_path), filename: 'test_image.png')
        expect(@item).to be_valid
      end

      it 'titleが40文字以内であれば出品できる' do
        @item.title = 'あいうえお'
        expect(@item).to be_valid
      end

      it 'detailが1000文字以内であれば出品できる' do
        @item.detail = 'あいうえお'
        expect(@item).to be_valid
      end

      it 'priceが300以上かつ9999999以下であれば出品できる' do
        @item.price = '12345'
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "titleが空では出品できない" do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it "detailが空では出品できない" do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end

      it "category_idが空では出品できない" do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it "condition_idが空では出品できない" do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it "shipcost_idが空では出品できない" do
        @item.shipcost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipcost can't be blank")
      end

      it "place_idが空では出品できない" do
        @item.place_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Place can't be blank")
      end

      it "shipdate_idが空では出品できない" do
        @item.shipdate_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipdate can't be blank")
      end

      it "priceが空では出品できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数値だと出品できない' do
        @item.price = 'あいうえお'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが¥300未満だと出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it 'priceが¥10,000,000以上だと出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it 'userが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

    end  
  end  
end
