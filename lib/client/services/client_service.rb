# frozen_string_literal: true

module Client
  module Services
    class ClientService
      def initialize(repository)
        @repository = repository
      end

      def find_by_partial_name(name)
        @repository.all.select do |client|
          client.name.downcase.include?(name.downcase)
        end
      end

      def find_duplicates_by_email
        @repository.all.group_by do |client|
          client.email.downcase 
          rescue nil
        end
        .select { |_, clients| clients.size > 1 }
      end
    end
  end
end
