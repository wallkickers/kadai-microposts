class Likerelation < ApplicationRecord
  #中間テーブルとの関係性を記載
  belongs_to :user
  belongs_to :micropost
  
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end
