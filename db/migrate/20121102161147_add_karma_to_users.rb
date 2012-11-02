class AddKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma, :integer, :default => 0
    add_column :users, :level, :integer, :default => 0
  end
end
