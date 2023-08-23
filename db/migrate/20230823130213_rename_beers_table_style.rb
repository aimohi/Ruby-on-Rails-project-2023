class RenameBeersTableStyle < ActiveRecord::Migration[7.0]
  def change
    change_table :beers do |t|
      t.rename :style, :old_style

      t.references :style, foreign_key: true
    end
  end
end
