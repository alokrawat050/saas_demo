class CreateGstins < ActiveRecord::Migration
  def change
    create_table :gstins do |t|
      t.belongs_to :company_master, index: true
      t.string :gstin_no
      t.string :created_by
      t.string :updated_by
      t.timestamps null: false
      t.boolean :del_flag, default: false
    end
  end
end
