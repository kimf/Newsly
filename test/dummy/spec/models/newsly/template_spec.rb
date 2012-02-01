# encoding: UTF-8
require 'spec_helper'

describe Newsly::Template do
  it "parses a hash of options and renders a string" do
    @template = Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} correct åäö?", :subject => "Welcome", :draft => false})
    @template.render("name" => "Kim", "email" => "kim@email.com").should == "Hello Kim is kim@email.com correct åäö?"
  end

  it "publishes a draft" do
    @parent = Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} correct åäö?", :subject => "Welcome", :draft => false})
    @draft  = Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} wrong or not åäö?", :subject => "Changed subject", :draft => true, :parent_id => @parent.id})
    
    @parent = @draft.publish
    
    @parent.subject.should == "Changed subject"
    @parent.body.should == "Hello {{name}} is {{email}} wrong or not åäö?"
    @parent.render("name" => "Kim", "email" => "kim@email.com").should == "Hello Kim is kim@email.com wrong or not åäö?"
  end

  describe "Rule validations" do
    before(:each) do
      @template = Newsly::Template.new({:name => "template", :body => "Hello", :subject => "Template", :draft => false})
    end
    it "validates multiple rules" do
      @template.validation_rules = "email, confirmation_link"
      @template.save
      @template.errors.messages[:body].first.should == "email and confirmation_link is required"
    end
    it "validates single rule" do
      @template.validation_rules = "signup_link"
      @template.save
      @template.errors.messages[:body].first.should == "signup_link is required"
    end    
  end
end