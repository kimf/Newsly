# encoding: UTF-8

module Newsly
  class Template < Newsly::LiquidModel
    self.table_name = 'newsly_templates'
    liquid_methods :subject, :body

    validates_presence_of :subject
    #validates_presence_of :parent_id, :if => :original
    #validates original is never draft and
    validate :body_must_follow_validation_rules
    
    ### Methods

    #
    # Takes a draft and copies information to the original
    #
    def publish
      original = Newsly::Template.find(self.parent_id)
      original.subject= self.subject
      original.body= self.body
      original.save
      original
    end

    def body_must_follow_validation_rules
      failed = []
      validation_rules.split(',').each do |rule|
        rule = rule.strip
        failed.push(rule) unless body=~ /{{rule}}/
      end
      errors.add(:body, "#{failed.to_sentence} is required") if failed.length > 0
    end
  end  
end