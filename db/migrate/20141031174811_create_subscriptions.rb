class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :customer, index: true
      t.text :lunch
      t.text :dinner
      t.string :upcoming_meal

      t.timestamps
    end
  end
end
