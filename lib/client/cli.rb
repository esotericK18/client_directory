# frozen_string_literal: true

require_relative 'repositories/client_repository'
require_relative 'services/search_clients_service'
require_relative 'services/find_duplicate_emails_service'

module Client
  # Main logic for the CLI
  class CLI
    def self.start(args)
      command = args.shift
      case command
      when 'search'
        query = args.join(' ')
        results = Services::SearchClientsService.new.call(query)
        if results.empty?
          puts "No clients found with name containing '#{query}'."
        else
          # puts "Found #{results.count} client(s):"
          results.each { |client| puts "#{client.name} (#{client.email})" }
        end
      when 'duplicates'
        duplicates = Services::FindDuplicateEmailsService.new.call
        if duplicates.empty?
          puts 'No duplicates found.'
        else
          duplicates.each do |email, clients|
            puts "Email: #{email}"
            clients.each { |client| puts "  > #{client.name}" }
          end
        end
      else
        puts "Unknown command. Use 'search <query>' or 'duplicates'."
      end
    end
  end
end
