class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :sender_id
      t.integer :sendto_id
      t.boolean :inbox
      t.boolean :outbox

      t.timestamps
    end
  end
end
