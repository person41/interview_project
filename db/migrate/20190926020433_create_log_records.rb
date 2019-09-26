class CreateLogRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :log_records do |t|
      t.date :year
      t.integer :population
      t.string :ip

      t.timestamps
    end
  end
end
