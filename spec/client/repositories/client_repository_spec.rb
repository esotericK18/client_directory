# frozen_string_literal: true

require 'json'
require_relative '../../spec_helper'

describe Client::Repositories::ClientRepository do
  let(:mock_data) do
    [
      { 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' },
      { 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' },
      { 'id' => 3, 'full_name' => 'Johnny Appleseed', 'email' => 'john@example.com' },
      { 'id' => 4, 'full_name' => 'Duplicate User', 'email' => 'duplicate@example.com' },
      { 'id' => 5, 'full_name' => 'Another Duplicate', 'email' => 'duplicate@example.com' }
    ]
  end

  let(:mock_parser) do
    instance_double('Client::Parsers::JsonParser').tap do |parser|
      allow(parser).to receive(:parse).and_return(mock_data)
    end
  end

  let(:repo) do
    Client::Repositories::ClientRepository.new.tap do |r|
      allow(Client::Parsers::JsonParser).to receive(:new).and_return(mock_parser)
      r.instance_variable_set(:@clients, r.send(:initialize, nil))
    end
  end

  it 'loads clients from JSON' do
    clients = repo.all
    expect(clients).to all(be_a(Client::Models::Client))
    expect(clients.map(&:name)).to include('John Doe', 'Jane Smith')
  end

  it 'returns all clients' do
    results = repo.all
    expect(results.map(&:name)).to include('John Doe', 'Jane Smith', 'Johnny Appleseed')
    expect(results.map(&:email)).to include('john@example.com', 'jane@example.com', 'duplicate@example.com')
    expect(results.size).to eq(5)
  end
end
