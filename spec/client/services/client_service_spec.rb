# frozen_string_literal: true

require_relative '../../spec_helper'

describe Client::Services::ClientService do
  let(:client1) { Client::Models::Client.new(id: 1, name: 'Rick', email: 'dup@example.com') }
  let(:client2) { Client::Models::Client.new(id: 2, name: 'Marcos', email: 'dup@example.com') }
  let(:mock_repo) do
    double('ClientRepository').tap do |repo|
      allow(repo)
        .to receive(:all)
        .and_return([client1, client2])
    end
  end

  it 'finds clients by partial name' do
    service = described_class.new(mock_repo)
    result = service.find_by_partial_name('Rick')
    expect(result.size).to eq(1)
    expect(result.first.name).to eq('Rick')
  end

  it 'finds duplicates by email' do
    service = described_class.new(mock_repo)
    duplicates = service.find_duplicates_by_email
    expect(duplicates.size).to eq(1)
    expect(duplicates['dup@example.com']).to include(client1, client2)
  end
end