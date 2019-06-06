class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.references :listing, foreign_key: true
      t.string :mission_type, null: false
      t.date :date, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end
