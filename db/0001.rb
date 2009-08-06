# yanked from configure block of findr.rb
class CreateUsers < ActiveRecord::Migration

  def self.up
    create_table "icons" do |t|
      t.string :client
      t.string :icon, :default => "unknown"
    end
  end

  def self.down
    drop_table "icons"
  end

