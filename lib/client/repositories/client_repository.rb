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

      def find_by_partial_name(query)
        @clients.select { |client| client.name.downcase.include?(query.downcase) }
      end

      def find_duplicates_by_email
        grouped = @clients.group_by { |client| client.email.downcase }

        grouped.select { |_, clients| clients.size > 1 }
      end
    end
  end
end
