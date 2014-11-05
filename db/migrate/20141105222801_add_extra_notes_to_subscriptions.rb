class AddExtraNotesToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :extra_notes, :text
  end
end
