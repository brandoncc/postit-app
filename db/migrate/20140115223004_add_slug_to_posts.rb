class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :strings
  end
end
