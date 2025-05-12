# frozen_string_literal: true

module Client
  module Models
    class Client
      attr_reader :id, :name, :email

      def initialize(id:, name:, email:)
        @id = id
        @name = name
        @email = email
      end
    end
  end
end
