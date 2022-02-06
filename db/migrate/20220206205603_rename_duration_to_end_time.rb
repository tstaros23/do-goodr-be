class RenameDurationToEndTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :duration, :end_time
  end
end
