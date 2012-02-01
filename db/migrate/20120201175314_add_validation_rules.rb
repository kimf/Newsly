class AddValidationRules < ActiveRecord::Migration
  def change
		add_column :newsly_templates, 	:validation_rules, :text  
	end
end
