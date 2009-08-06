# yanked from configure block of findr.rb
class CreateUsers < ActiveRecord::Migration

  def self.up
    create_table "searches" do |t|
      t.string :sstring
      t.integer :howmany, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table "searches"
  end

