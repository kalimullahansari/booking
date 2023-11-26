class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :status, default: 0, null:false
      t.string :date, null:false
      t.string :time, null:false
      t.references :admin, foreign_key: {to_table: :users}, null:true
      t.references :regular_user, foreign_key:{to_table: :users} , null:false
      t.timestamps
    end
  end
end
