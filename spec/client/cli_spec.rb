# frozen_string_literal: true

require 'stringio'
require_relative '../spec_helper'
require_relative '../../lib/client/cli'
require_relative '../../lib/client/models/client'

describe Client::CLI do
  let(:client1) { Client::Models::Client.new(id: 1, name: 'John Doe', email: 'john@example.com') }
  let(:client2) { Client::Models::Client.new(id: 2, name: 'Johnny Smith', email: 'john@example.com') }

  before do
    allow_any_instance_of(Client::Services::ClientService)
      .to receive(:find_by_partial_name)
      .and_return([client1, client2])
    allow_any_instance_of(Client::Services::ClientService)
      .to receive(:find_duplicates_by_email)
      .and_return(
        {
          'john@example.com' => [client1, client2]
        }
      )
  end

  def capture_stdout
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end

  it "prints matching clients for 'search' command" do
    output = capture_stdout { described_class.start(%w[search john]) }
    expect(output).to include('John Doe (john@example.com)')
    expect(output).to include('Johnny Smith (john@example.com)')
  end

  it "prints duplicates for 'duplicates' command" do
    output = capture_stdout { described_class.start(['duplicates']) }
    expect(output).to include('Email: john@example.com')
    expect(output).to include('  > John Doe')
    expect(output).to include('  > Johnny Smith')
  end

  it 'prints error message for unknown command' do
    output = capture_stdout { described_class.start(['invalid']) }
    expect(output).to include('Unknown command')
  end

  it 'prints no clients found message if search returns empty' do
    allow_any_instance_of(Client::Services::ClientService).to receive(:find_by_partial_name).and_return([])
    output = capture_stdout { described_class.start(%w[search zzz]) }
    expect(output).to include("No clients found with name containing 'zzz'.")
  end

  it 'prints no duplicates found if none exist' do
    allow_any_instance_of(Client::Services::ClientService).to receive(:find_duplicates_by_email).and_return({})
    output = capture_stdout { described_class.start(['duplicates']) }
    expect(output).to include('No duplicates found.')
  end

  it 'prints error if no command is given' do
    output = capture_stdout { described_class.start([]) }
    expect(output).to include('Unknown command')
  end

  it 'prints fallback if search query is empty' do
    allow_any_instance_of(Client::Services::ClientService).to receive(:find_by_partial_name).with('').and_return([])
    output = capture_stdout { described_class.start(['search']) }
    expect(output).to include("No clients found with name containing ''.")
  end

  it 'handles extra whitespace in arguments' do
    allow_any_instance_of(Client::Services::ClientService)
      .to receive(:find_by_partial_name).with('   john   doe  ').and_return([client1])
    output = capture_stdout { described_class.start(['search', '   john   doe  ']) }
    expect(output).to include('John Doe (john@example.com)')
  end
end
