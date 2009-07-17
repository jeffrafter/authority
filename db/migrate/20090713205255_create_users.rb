class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.boolean :confirmed,           :null => false, :default => false
      t.string  :email,               :null => false
      t.string  :crypted_password,    :null => false
      t.string  :password_salt,       :null => false
      t.string  :persistence_token,   :null => false
      t.string  :single_access_token, :null => false
      t.string  :perishable_token,    :null => false
      t.string  :timezone,            :null => false, :default => 'UTC' 
      t.string  :locale,              :null => false, :default => 'en'
      t.string  :name                
      t.string  :organization        
      t.string  :phone               
      t.string  :location            
      t.string  :website             
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
