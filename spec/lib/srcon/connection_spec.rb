require 'spec_helper'

RSpec.describe Srcon::Connection do
  #TODO: Mock the server?
  subject(:connection) { described_class.new('107.173.81.126', 38517) }

  it 'opens a socket to the specified server' do
    expect(connection.socket).to be_a(TCPSocket)
    expect(connection.socket.closed?).to be_falsey
  end
end
