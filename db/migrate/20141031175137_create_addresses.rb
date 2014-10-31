class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :customer, index: true
      t.string :first_name
      t.string :last_name
      t.text :street_address
      t.string :suite
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
