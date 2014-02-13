class DropAttribute < ActiveRecord::Migration
    def self.up
        drop_table :attributes
    end 
    def self.down
	    create_table :attributes do |t|
	    	t.string :name
	    	t.string :rule

	    	t.timestamps
	    end
    end
end
