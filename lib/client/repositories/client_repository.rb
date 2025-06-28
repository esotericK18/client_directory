# frozen_string_literal: true

require 'json'
require_relative '../models/client'
require_relative '../parsers/json_parser'

module Client
  module Repositories
    class ClientRepository
      def initialize(file_path = 'lib/data/clients.json')
        @clients = Parsers::JsonParser.new(file_path).parse.map do |data|
          Models::Client.new(
            id: data['id'],
            name: data['full_name'],
            email: data['email']
          )
        end
      end

      def all
        @clients
      end
    end
  end
end
