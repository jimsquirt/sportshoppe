class Message < ActiveRecord::Base
  attr_accessible :content, :inbox, :outbox, :sender_id, :sendto_id
  validates :content, :presence => true
end
