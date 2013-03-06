class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :quality, :user_id
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  validates_presence_of :name, :price, :quality
  validates :name, :length => {:minimum => 5}
  validates :name, :uniqueness => true
  validates :price, :numericality => {:greater_than => 0}

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
