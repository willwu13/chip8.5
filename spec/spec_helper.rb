# spec/spec_helper.rb
# This file is loaded by RSpec, usually from rails_helper.rb.
# Do NOT require 'rspec' or WebMock here.

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use the specified formatter
  config.formatter = :documentation

  # Run specs in random order
  config.order = :random

  # Filter lines from Rails gems in backtraces
  config.filter_gems_from_backtrace("rails", "railties", "active_record")

  # If you need to include support files, do it here, without stubs
  # Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
end
