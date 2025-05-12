# frozen_string_literal: true

require_relative '../repositories/client_repository'

module Client
  module Services
    class FindDuplicateEmailsService
      def initialize(repository = Repositories::ClientRepository.new)
        @repository = repository
      end

      def call
        @repository.find_duplicates_by_email
      end
    end
  end
end
