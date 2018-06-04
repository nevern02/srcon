require 'spec_helper'

# Stand-in for TCPSocket for testing purposes. Not a great pattern.
class MockSocket < TCPSocket
  attr_reader :host, :port, :buffer

  def initialize(host, port)
    @host   = host
    @port   = port
    @buffer = []
  end

  def closed?
    true
  end

  def sendmsg(string)
    buffer << string
  end
end

RSpec.describe Srcon::Connection do
  let(:host) { '123.45.67.8' }
  let(:port) { 38517 }

  subject(:connection) { described_class.new(host, port) }

  let(:mock_socket) { MockSocket.new(host, port) }

  before(:each) do
    allow(TCPSocket).to receive(:new).and_return(mock_socket)
  end

  it 'opens a socket to the specified server' do
    expect(connection.socket).to be_a(TCPSocket)
    expect(connection.socket.host).to eq(host)
    expect(connection.socket.port).to eq(port)
  end

  it 'sends messages' do
    expect {
      connection.send('hello world')
    }.to change { mock_socket.buffer.length }.by(1)
  end
end
