# frozen_string_literal: true

require 'json'
module Client
  module Parsers
    class JsonParser
      def initialize(file_path)
        @file_path = file_path
      end

      def parse
        JSON.parse(File.read(@file_path))
      rescue StandardError => e
        warn "Error reading or parsing JSON: #{e.message}"
        []
      end
    end
  end
end
