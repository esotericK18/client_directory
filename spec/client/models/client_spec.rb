# frozen_string_literal: true

require_relative '../../spec_helper'

describe Client::Models::Client do
  it 'initializes a client with id, name, and email, and verifies attribute assignment' do
    client = described_class.new(id: 1, name: 'John Doe', email: 'john@example.com')
    expect(client.id).to eq(1)
    expect(client.name).to eq('John Doe')
    expect(client.email).to eq('john@example.com')
  end
end
