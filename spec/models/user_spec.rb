require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '登録できる場合' do
      it 'nicknameとemail、fam_name、first_name、fam_kana、first_kana、birthday、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上であれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end

      it 'fam_nameとfirst_nameが全角であれば登録できる' do
        @user.fam_name = '山田'
        @user.first_name = 'たろう'
        expect(@user).to be_valid
      end

      it 'fam_kanaとfirst_kanaが全角カナであれば登録できる' do
        @user.fam_kana = 'ヤマダ'
        @user.first_kana = 'タロウ'
        expect(@user).to be_valid
      end

      it 'passwordが英数字混合であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end

      it 'emailは@を含んでいれば登録できる' do
        @user.email = 'test@mail'
        expect(@user).to be_valid
      end
    end

    context '登録できない場合' do
      it 'fam_nameが空では登録できない' do
        @user.fam_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Fam name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'fam_nameが半角では登録できない' do
        @user.fam_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Fam name 全角文字を使用してください')
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it 'fam_kanaが空では登録できない' do
        @user.fam_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Fam kana can't be blank")
      end

      it 'first_kanaが空では登録できない' do
        @user.first_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana can't be blank")
      end

      it 'fam_kanaが半角では登録できない' do
        @user.fam_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Fam kana 全角カナを使用してください')
      end

      it 'first_kanaが半角では登録できない' do
        @user.first_kana = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First kana 全角カナを使用してください')
      end

      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it 'passwordが数字だけだと登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字の混合である必要があります')
      end

      it 'passwordが英字だけだと登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字の混合である必要があります')
      end

      it 'passwordが全角だと登録できない' do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字の混合である必要があります')
      end
    end
  end
end
