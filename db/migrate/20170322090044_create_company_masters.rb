class CreateCompanyMasters < ActiveRecord::Migration
  def change
    create_table :company_masters do |t|
      t.string :company_id
      t.string :company_name
      t.integer :owner_id
      t.timestamps
      t.string :updated_by
      t.boolean :del_flag
    end
  end
end
