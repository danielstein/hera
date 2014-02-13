class RenameAttributeInspectionToAnswer < ActiveRecord::Migration
    def self.up
        rename_table :attribute_inspections, :answers
    end 
    def self.down
        rename_table :answers, :attribute_inspections
    end
end
