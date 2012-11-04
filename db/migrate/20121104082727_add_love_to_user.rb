class AddLoveToUser < ActiveRecord::Migration
  def change
    add_column :users, :love, :integer, :default => 0

  end
end
