class CreateUserReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :user_reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
