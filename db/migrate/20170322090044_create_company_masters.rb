class CreateCompanyMasters < ActiveRecord::Migration
  def change
    create_table :company_masters do |t|
      t.string :company_id
      t.string :company_name
      t.string :company_short_name
      t.string :company_owner_name
      t.string :company_owner_email
      t.string :encrypted_company_pan_no
      t.string :encrypted_company_pan_no_iv
      t.string :company_establish_dt
      t.timestamps
      t.string :created_by
      t.string :updated_by
      t.boolean :del_flag, default: false
    end
  end
end
