class AddSlugToSeminars < ActiveRecord::Migration[7.0]
  def change
    add_column :seminars, :slug, :string
    add_index :seminars, :slug, unique: true
  end
end
