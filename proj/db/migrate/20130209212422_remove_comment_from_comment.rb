class RemoveCommentFromComment < ActiveRecord::Migration
  def up
    remove_column :comments, :comment
  end

  def down
    add_column :comments, :comment, :text
  end
end
