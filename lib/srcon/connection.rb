require 'socket'

module Srcon
  class Connection
    attr_reader :host, :port, :socket

    # @param [String] host The host the server is listening on
    # @param [Integer] port The port the server is listening on
    # @param [String] password The password for authentication
    def initialize(host, port, password = nil)
      @host     = host
      @port     = port
      @password = password

      connect
    end

    def receive
      socket.recvmsg
    end

    private

    def authenticate
      packet = Srcon::Packet.new(@password, Srcon::Packet::SERVERDATA_AUTH)
      socket.sendmsg(packet.to_b)
    end

    def connect
      @socket = TCPSocket.new(host, port)

      return unless @password

      authenticate
    end
  end
end
