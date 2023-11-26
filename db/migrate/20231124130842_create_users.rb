class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :type , null:false
      t.string :password_digest, null:false
      t.string :email, null:false, index:{unique:true}
      t.timestamps
    end
  end
end
