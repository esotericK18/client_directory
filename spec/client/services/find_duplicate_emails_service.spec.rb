# frozen_string_literal: true

require_relative '../../spec_helper'

describe Client::Services::FindDuplicateEmailsService do
  let(:client1) { Client::Models::Client.new(id: 1, name: 'Rick', email: 'dup@example.com') }
  let(:client2) { Client::Models::Client.new(id: 2, name: 'Marcos', email: 'dup@example.com') }
  let(:mock_repo) do
    double('ClientRepository').tap do |repo|
      allow(repo).to receive(:find_duplicates_by_email).and_return({ 'dup@example.com' => [client1, client2] })
    end
  end

  it 'returns duplicated clients grouped by email' do
    service = described_class.new(mock_repo)
    result = service.call
    expect(result['dup@example.com'].size).to eq(2)
    expect(result['dup@example.com']).to include(client1, client2)
  end
end
