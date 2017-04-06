class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :subdomain_name
      t.integer :owner_id
      t.integer :plan_id
      t.string :updated_by
      t.boolean :del_flag, default: false
      t.timestamps null: false
    end
  end
end
