$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

if ENV["ENABLE_COVERAGE"] == "1"
  require "simplecov"
  SimpleCov.start
end
