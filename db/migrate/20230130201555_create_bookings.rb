class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :ticket_qty
      t.float :amount_paid
      t.string :stripe_transaction_id
      t.references :customer, null: false, foreign_key: true
      t.references :seminar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
