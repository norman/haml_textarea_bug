require "bundler/setup"
require "action_view"
require "active_model"
require "haml"
require "haml/template"
require "test/unit"

class Person
  extend ActiveModel::Naming
  attr_accessor :name
  def url_for; "/me" end
  def self.model_name; @model_name ||= ::ActiveModel::Name.new(self) end
  def to_key; ["1"] end
end

class TestView < ActionView::Base
  def person_path(*args); "/" end
  def protect_against_forgery?; false end
end

class HamlTextareaTest < Test::Unit::TestCase
  def setup
    Haml::Template.options[:ugly] = false
    @view = TestView.new
  end

  def test_html_textarea_tag
    output = @view.render :file => "textarea"
    assert_equal "<textarea>hello world!</textarea>\n", output
  end

  def test_text_area_helper
    output = @view.render :file => "form_for"
    assert_match(/\>\nJoe\</, output)
  end
end
