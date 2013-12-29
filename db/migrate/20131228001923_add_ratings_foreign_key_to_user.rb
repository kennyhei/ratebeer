class AddRatingsForeignKeyToUser < ActiveRecord::Migration
  def change
    add_column :ratings, :user_id, :integer # table, attribute, type
  end
end
