class AddDinnerTimeToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :dinner_time, :time
  end
end
