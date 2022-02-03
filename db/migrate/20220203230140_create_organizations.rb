class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :location
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
