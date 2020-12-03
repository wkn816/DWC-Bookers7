class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  attachment :profile_image, destroy: false
  has_many :books, dependent: :destroy

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end


  validates :name, uniqueness: true
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end

#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :trackable,:validatable
  
#   attachment :profile_image, destroy: false
#   has_many :books, dependent: :destroy

#   #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
#   validates :name, length: {maximum: 20, minimum: 2}
#   validates :introduction, length: {maximum: 50}

