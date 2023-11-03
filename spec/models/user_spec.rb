require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it 'fam_nameが空では登録できない' do
      @user.fam_name = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Fam name can't be blank")
    end

    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'fam_nameが半角では登録できない' do
      @user.fam_name = 'aaaaa'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Fam name 全角文字を使用してください')
    end

    it 'first_nameが半角では登録できない' do
      @user.first_name = 'aaaaa'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
    end

    it 'fam_kanaが空では登録できない' do
      @user.fam_kana = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("Fam kana can't be blank")
    end

    it 'first_kanaが空では登録できない' do
      @user.first_kana = ''
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include("First kana can't be blank")
    end

    it 'fam_kanaが半角では登録できない' do
      @user.fam_kana = 'aaaaa'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Fam kana 全角カナを使用してください')
    end

    it 'first_kanaが半角では登録できない' do
      @user.first_kana = 'aaaaa'
      @user.valid?
      # binding.pry
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
      # binding.pry
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
      # binding.pry
      expect(@user.errors.full_messages).to include('Password は英数字の混合である必要があります')
    end

    it 'passwordが英字だけだと登録できない' do
      @user.password = 'abcdef'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Password は英数字の混合である必要があります')
    end

    it 'passwordが全角だと登録できない' do
      @user.password = 'ああああああ'
      @user.valid?
      # binding.pry
      expect(@user.errors.full_messages).to include('Password は英数字の混合である必要があります')
    end
  end
end
