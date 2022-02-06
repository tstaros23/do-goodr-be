class RenameToEndTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :, :end_time
  end
end
