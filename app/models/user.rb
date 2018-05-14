class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name,presence: true,length:{maximum:50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  #中間テーブルとの関係性を記載[フォロー/アンフォロー]
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  #中間テーブルとの関係性を記載[Like/Unlike]
  has_many :likerelations
  has_many :like_posts, through: :likerelations , source: :micropost

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end

  def like(micropost)
    #unless self.micropost == micropost
      self.likerelations.find_or_create_by(micropost_id: micropost.id)
    #end
  end
  
  def unlike(micropost)
    likerelation = self.likerelations.find_by(micropost_id: micropost.id)
    likerelation.destroy if likerelation
  end
  
  def liking?(micropost)
    self.like_posts.include?(micropost)
  end

end



