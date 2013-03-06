class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :product_id
  belongs_to :product

  validates :body, :presence => true
  validates :body, :length => {:minimum => 1}


end
