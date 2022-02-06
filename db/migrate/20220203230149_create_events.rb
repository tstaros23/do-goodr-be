class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :organization, foreign_key: true
      t.string :name
      t.integer :category
      t.string :address
      t.string :description
      t.integer :vols_required
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
