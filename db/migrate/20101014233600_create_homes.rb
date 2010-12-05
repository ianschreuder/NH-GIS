class CreateHomes < ActiveRecord::Migration
  def self.up
    create_table :homes do |t|
      t.integer :facility_id
      t.string :provider_number
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.integer :num_beds
      t.integer :num_residents
      t.string :category
      t.string :type_owner
      t.integer :in_hospital
      t.integer :multiple_ownership
      t.string :councils
      t.integer :ccrc
      t.integer :qis_home
      t.integer :sff

      t.timestamps
    end
  end

  def self.down
    drop_table :homes
  end
end
