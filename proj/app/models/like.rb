class Like < ActiveRecord::Base
  attr_accessible :product_id, :user_id
  belongs_to :product

end
