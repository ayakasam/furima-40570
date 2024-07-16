require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "必要事項を全て過不足なく入力すると登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "Emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "Emailに@を含まないと登録できない" do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it "重複したEmailでは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it "Passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "Passwordが5文字以下では登録できない" do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it "Passwordが半角数字のみでは登録できない" do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
      it "Passwordが半角英字のみでは登録できない" do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
      it "全角文字を含むPasswordでは登録できない" do
        @user.password = 'ａａａ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid. Include both letters and numbers"
      end
      it "Password_confirmationがPasswordと一致しないと登録できない" do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "Nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "Lastnameが空では登録できない" do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname can't be blank"
      end
      it "Lastnameを全角で入力しないと登録できない" do
        @user.lastname = 'ﾀｶﾊｼ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname is invalid. Input full-width characters"
      end
      it "Firstnameが空では登録できない" do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname can't be blank"
      end
      it "Firstnameが全角で入力しないと登録できない" do
        @user.firstname = 'ｷｮｳﾍｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname is invalid. Input full-width characters"
      end
      it "Lastname_kanaが空では登録できない" do
        @user.lastname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname kana can't be blank"
      end
      it "Lastname_kanaが全角カタカナでないと登録できない" do
        @user.lastname_kana = 'ﾀｶﾊｼ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Lastname kana is invalid. Input full-width katakana characters"
      end
      it "Firstname_kanaが空では登録できない" do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kana can't be blank"
      end
      it "Firstname_kanaが全角カタカナでないと登録できない" do
        @user.firstname_kana = 'ｷｮｳﾍｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Firstname kana is invalid. Input full-width katakana characters"
      end
      it "Birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
