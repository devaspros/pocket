# spec/support/custom_matchers/have_constant.rb

# Seen at https://stackoverflow.com/a/13916925/1407371
RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end
