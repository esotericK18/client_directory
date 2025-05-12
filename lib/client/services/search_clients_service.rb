# frozen_string_literal: true

require_relative '../repositories/client_repository'

module Client
  module Services
    class SearchClientsService
      def initialize(repository = Repositories::ClientRepository.new)
        @repository = repository
      end

      def call(query)
        @repository.find_by_partial_name(query)
      end
    end
  end
end
