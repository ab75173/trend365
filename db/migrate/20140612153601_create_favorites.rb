class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :nyt_id
      t.string :title
      t.references :user
    end
  end
end
