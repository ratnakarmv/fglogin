class AddLunchTimeToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :lunch_time, :time
  end
end
