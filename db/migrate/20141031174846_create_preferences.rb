class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :subscription, index: true
      t.references :track, index: true

      t.timestamps
    end
  end
end
