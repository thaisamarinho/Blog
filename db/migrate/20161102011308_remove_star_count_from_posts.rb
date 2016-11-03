class RemoveStarCountFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :star_count
  end
end
