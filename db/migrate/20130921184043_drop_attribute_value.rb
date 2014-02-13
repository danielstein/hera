class DropAttributeValue < ActiveRecord::Migration
    def self.up
        drop_table :attribute_values
    end 
    def self.down
    	create_table :attribute_values do |t|
	    	t.string :value
	    	t.datetime :date

	    	t.timestamps
	    end
    end
end
