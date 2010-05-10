ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require 'modelfactory'
require File.expand_path(File.dirname(__FILE__) + '/laika_spec_helper')

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

ModelFactory.configure do
  default(Setting) do
    name  { |i| "factory setting #{i}" }
    value { |i| "factory value #{i}" }
  end

  default(ContentError) do
    validator { 'factory' }
  end

  default(Patient) do
    name { "Harry Manchester" }
    user { User.factory.create }
  end

  default(InsuranceProvider) do
    insurance_provider_patient {
      InsuranceProviderPatient.factory.create(:insurance_provider => self)
    }
    insurance_provider_subscriber {
      InsuranceProviderSubscriber.factory.create(:insurance_provider => self)
    }
    insurance_provider_guarantor {
      InsuranceProviderGuarantor.factory.create(:insurance_provider => self)
    }
  end

  default(User) do
    email { |i| "factoryuser#{i}@example.com" }
    first_name { "Harry" }
    last_name { "Manchester" }
    password { "password" }
    password_confirmation { password }
  end

  default(Vendor) do
    public_id { |i| "FACTORYVENDOR#{i}" }
    user { User.factory.create }
  end

  default(TestPlan) do
    patient { Patient.factory.create }
    user { User.factory.create }
    vendor { Vendor.factory.create }
  end

  default(XdsProvideAndRegisterPlan) do
    patient { Patient.factory.create }
    user { User.factory.create }
    vendor { Vendor.factory.create }
    test_type_data { XDS::Metadata.new }
  end

  default(C62InspectionPlan) do
    patient { Patient.factory.create }
    user { User.factory.create }
    vendor { Vendor.factory.create }
    clinical_document { ClinicalDocument.factory.create(:doc_type => 'C62') }
  end

  default(ClinicalDocument) do
    size { 256 }
    filename { 'factory_document' }
  end

  default(Gender) do
    name { 'Male' }
    code { 'M' }
    description { 'Male' }
  end

end

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses its own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end
