# frozen_string_literal: true

require 'rspec'
require_relative '../lib/client'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
