class CreateNutritionistServices < ActiveRecord::Migration[7.2]
  def change
    create_table :nutritionist_services do |t|
      t.references :nutritionist, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.timestamps
      t.index [:nutritionist_id, :service_id], unique: true
    end
  end
end
