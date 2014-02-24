# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_group 'Processors', '/lib/mincer/processors'
  add_group 'ActionView', '/lib/mincer/action_view'
end
require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'kaminari'
Kaminari::Hooks.init
require 'mincer'

require 'support/postgres_adapter'
require 'support/sqlite3_adapter'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.after do
    ActiveRecord::Base.clear_active_connections!
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
