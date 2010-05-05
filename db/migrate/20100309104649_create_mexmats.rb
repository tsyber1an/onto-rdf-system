class CreateMexmats < ActiveRecord::Migration
  def self.up
    create_table :mexmats do |t|
			t.integer :group, :year
			t.string :firstname, :lastname, :middlename
      t.timestamps
    end
  end

  def self.down
    drop_table :mexmats
  end
end
