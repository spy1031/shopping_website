class RenameOrderAttriute < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :aomount, :amount
  end
end
