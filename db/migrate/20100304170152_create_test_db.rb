class CreateTestDb < ActiveRecord::Migration
  def self.up
    create_table :mmfds do |t|
	  	t.integer :year, :group
	  	t.string :firstname, :lastname, :middlename, :phone, :email, :url 
    end
  end

  def self.down
  	drop_table :mmfds
  end
end
