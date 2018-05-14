class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id,presence: true
  validates :content,presence: true,length: {maximum: 255}

  #中間テーブルとの関係性を記載
  has_many :likerelations , dependent: :destroy
  has_many :users, through: :likerelations

end
