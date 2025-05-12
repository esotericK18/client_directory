# frozen_string_literal: true

require_relative '../../spec_helper'

describe Client::Services::SearchClientsService do
  let(:mock_repo) do
    double('ClientRepository').tap do |repo|
      allow(repo)
        .to receive(:find_by_partial_name)
        .with('jose')
        .and_return(
          [
            Client::Models::Client.new(
              id: 1,
              name: 'Jose Rizal',
              email: 'john@example.com'
            )
          ]
        )
    end
  end

  it 'calls repository and returns matched clients' do
    service = described_class.new(mock_repo)
    result = service.call('jose')
    expect(result.size).to eq(1)
    expect(result.first.name).to eq('Jose Rizal')
  end
end
