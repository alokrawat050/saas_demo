class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :account, index: true
      t.string :created_by
      t.string :updated_by
      t.boolean :del_flag, default: false
      t.timestamps null: false
    end
  end
end
