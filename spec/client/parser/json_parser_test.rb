# frozen_string_literal: true

require_relative '../../spec_helper'
require 'json'
require_relative '../../lib/client/parsers/json_parser'

describe Client::Parsers::JsonParser do
  before do
    allow(File).to receive(:read).and_call_original
  end

  it 'parses valid JSON into an array of hashes' do
    json_content = JSON.generate([{ "id" => 1, "name" => "Test User", "email" => "test@example.com" }])
    allow(File).to receive(:read).with('valid.json').and_return(json_content)

    parser = described_class.new('valid.json')
    result = parser.parse

    expect(result).to be_an(Array)
    expect(result.first['name']).to eq('Test User')
  end

  it 'returns an empty array on invalid JSON' do
    allow(File).to receive(:read).with('invalid.json').and_return('{invalid: true,')

    parser = described_class.new('invalid.json')
    expect { parser.parse }.to output(/Error reading or parsing JSON/).to_stderr
    result = parser.parse
    expect(result).to eq([])
  end

  it 'returns an empty array if file does not exist' do
    allow(File).to receive(:read).with('missing.json').and_raise(Errno::ENOENT)

    parser = described_class.new('missing.json')
    expect { parser.parse }.to output(/Error reading or parsing JSON/).to_stderr
    result = parser.parse
    expect(result).to eq([])
  end
end
