require "minitest/autorun"
require "json_matchers/minitest/assertions"
require './lib/db_import'

JsonMatchers.schema_root = "test/support/api/schemas"
Minitest::Test.include(JsonMatchers::Minitest::Assertions)

DbImport.load_all("#{App.settings.root}/db/data")