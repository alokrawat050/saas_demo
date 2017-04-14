class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :client_id
      t.string :client_name
      t.string :client_short_name
      t.string :owner_name
      t.string :owner_email
      t.string :encrypted_client_pan_no
      t.string :encrypted_client_pan_no_iv
      t.string :gst_username
      t.string :encrypted_gst_password
      t.string :encrypted_gst_password_iv
      t.string :establish_dt
      t.string :created_by
      t.string :updated_by
      t.boolean :del_flag, default: false
      
      t.timestamps
    end
  end
end
