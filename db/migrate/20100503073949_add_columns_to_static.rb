class AddColumnsToStatic < ActiveRecord::Migration
  def self.up
    add_column :statics, :skey, :string
    add_column :statics, :svalue, :string
    add_column :statics, :stype, :string
  end

  def self.down
    remove_column :statics, :stype
    remove_column :statics, :svalue
    remove_column :statics, :skey
  end
end
