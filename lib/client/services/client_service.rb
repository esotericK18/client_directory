# frozen_string_literal: true

module Client
  module Services
    class ClientService
      def initialize(repository)
        @repository = repository
      end

      def find_by_partial_name(name)
        @repository.find_by_partial_name(name)
      end

      def find_duplicates_by_email
        @repository.find_duplicates_by_email
      end
    end
  end
end
