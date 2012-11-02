class AddLoveToFrustrations < ActiveRecord::Migration
  def change
    add_column :frustrations, :love, :integer, :default => 0
    add_column :frustrations, :karma, :integer, :default => 0
  end
end
