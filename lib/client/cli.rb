# frozen_string_literal: true
require_relative 'repositories/client_repository'
require_relative 'services/client_service'

module Client
  # Main logic for the CLI
  class CLI
    def self.start(args)
      repo = Repositories::ClientRepository.new
      service = Services::ClientService.new(repo)
      command = args.shift
      
      case command
      when 'search'
        query = args.join(' ')
        results = service.find_by_partial_name(query)
        if results.empty?
          puts "No clients found with name containing '#{query}'."
        else
          # puts "Found #{results.count} client(s):"
          results.each { |client| puts "#{client.name} (#{client.email})" }
        end
      when 'duplicates'
        duplicates = service.find_duplicates_by_email
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
