class CreateOptionValuesVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :option_values_variants do |t|
      t.references :option_value, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
