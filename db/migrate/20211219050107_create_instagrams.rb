class CreateInstagrams < ActiveRecord::Migration[6.1]
  def change
    create_table :instagrams do |t|
      t.text :comment
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :image4

      t.timestamps
    end
  end
end
