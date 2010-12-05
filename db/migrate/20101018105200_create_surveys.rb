class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.integer :home_id
      t.string :provider_number
      t.datetime :survey_date
      t.integer :qis
    end
  end

  def self.down
    drop_table :surveys
  end
end
