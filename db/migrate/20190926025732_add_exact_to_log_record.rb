class AddExactToLogRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :log_records, :exact, :boolean
  end
end
