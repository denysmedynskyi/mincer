# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

# Disabling logging
#$stderr = StringIO.new

require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_group 'Processors', '/lib/mincer/processors'
  add_group 'ActionView', '/lib/mincer/action_view'
end

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'rubygems'
require 'bundler/setup'
require 'action_view'
require 'active_record'
require 'active_support'

require 'will_paginate'
#require 'will_paginate/active_record'

require 'kaminari'
Kaminari::Hooks.init

require 'mincer'

require 'support/postgres_adapter'
require 'support/sqlite3_adapter'

require 'generator_spec'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.after do
    ActiveRecord::Base.clear_active_connections!
  end

  config.before do
    # Restoring defaults
    Mincer.configure do |config|
      config.pg_search do |search|
        search.param_name = 'pattern'
        search.fulltext_engine = { ignore_accent: true, any_word: false, dictionary: :simple, ignore_case: false }
        search.trigram_engine = { ignore_accent: true, threshold: 0.3 }
        search.array_engine = { ignore_accent: true, any_word: true }
        search.engines = [Mincer::PgSearch::SearchEngines::Fulltext, Mincer::PgSearch::SearchEngines::Array, Mincer::PgSearch::SearchEngines::Trigram]
      end
      config.pagination do |paginaition|
        paginaition.page_param_name = :page
        paginaition.per_page_param_name = :per_page
      end
      config.sorting do |paginaition|
        paginaition.sort_param_name = :sort
        paginaition.sort_attribute = :id
        paginaition.order_param_name = :order
        paginaition.order_attribute = :asc
      end
    end
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
