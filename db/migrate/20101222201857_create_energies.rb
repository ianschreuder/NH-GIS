class CreateEnergies < ActiveRecord::Migration
  def self.up
    create_table :energies do |t|
      

      t.timestamps
    end
  end

  def self.down
    drop_table :energies
  end
end
