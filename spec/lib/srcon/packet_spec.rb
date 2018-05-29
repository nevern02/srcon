require 'spec_helper'

RSpec.describe Srcon::Packet do
  let(:message) { 'Hello World!' }

  subject(:packet) { described_class.new(message) }

  it 'calculates the size of the packet' do
    expected_size = message.bytesize + 10
    expect(packet.size).to eq(expected_size)
  end

  it 'has a size limit' do
    expect {
      packet.body = ('a' * 4097)
    }.to raise_error(Srcon::MaxPacketSize)
  end

  describe 'packet types' do
    it 'has a SERVERDATA_AUTH type' do
      expect(described_class::SERVERDATA_AUTH).to eq(3)
    end

    it 'has a SERVERDATA_AUTH_RESPONSE type' do
      expect(described_class::SERVERDATA_AUTH_RESPONSE).to eq(2)
    end

    it 'has a SERVERDATA_EXECCOMMAND type' do
      expect(described_class::SERVERDATA_EXECCOMMAND).to eq(2)
    end

    it 'has a SERVERDATA_RESPONSE_VALUE type' do
      expect(described_class::SERVERDATA_RESPONSE_VALUE).to eq(0)
    end
  end

  it 'binary-encodes a string for sending across the socket' do
    string = ["\x16\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00Hello World!\x00"].pack('Z*')
    expect(packet.to_b).to eq(string)
  end

  describe 'unpacking a received message' do
    let(:body)     { ["\x17\x00\x00\x00*\x00\x00\x00\x02\x00\x00\x00Authenticated."].pack('Z*') }
    let(:addrinfo) { Addrinfo.new('', nil, :SOCK_STREAM) }
    let(:rflags)   { 1073741824 }

    subject(:packet) { described_class.from_message(body, addrinfo, rflags) }

    it 'unpacks a received message' do
      expect(packet.body).to eq('Authenticated.')
    end
  end
end
