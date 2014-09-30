class LinkForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :company_name, :salesforce
  validates_presence_of :company_name

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
