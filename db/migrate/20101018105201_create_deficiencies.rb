class CreateDeficiencies < ActiveRecord::Migration
  def self.up
    create_table :deficiencies do |t|
      t.integer :home_id
      t.integer :survey_id
      t.string :provider_number
      t.datetime :survey_date
      t.datetime :date_of_correction
      t.string :severity
      t.string :deficiency_type
      t.string :category_code
      t.string :category_desc
      t.string :deficiency
      t.string :scope
      t.string :level_of_harm

      t.timestamps
    end
  end

  def self.down
    drop_table :deficiencies
  end
end


