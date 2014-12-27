$LOAD_PATH.unshift(__dir__)

require 'bundler/setup'
require 'sse/application'

run SSE::Application
