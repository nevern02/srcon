require 'socket'

module Srcon
  class Connection
    class AuthenticationFailure < StandardError; end

    attr_reader :host, :port, :socket

    # @param [String] host The host the server is listening on
    # @param [Integer] port The port the server is listening on
    # @param [String] password The password for authentication
    def initialize(host, port, password = nil)
      @host = host
      @port = port
      @id   = rand(Process.pid)

      connect!(password)
    end

    # @return [Srcon::Packet] The deconstructed packet received from the socket
    def receive
      Srcon::Packet.from_message(*socket.recvmsg)
    end

    # @param [String] message A message to send to the server
    # @param [Integer] type The type of message
    #
    # @return [Integer] The number of bytes that were sent
    def send(message, type = Srcon::Packet::SERVERDATA_EXECCOMMAND)
      packet = Srcon::Packet.new(message, type, @id)
      @id += 1
      socket&.sendmsg(packet.to_b)
    end

    private

    def connect!(password = nil)
      @socket = TCPSocket.new(host, port)

      return unless password

      # Authenticate if a password was provided
      send(password, Srcon::Packet::SERVERDATA_AUTH)

      response = receive

      raise AuthenticationFailure.new("Failed RCON auth to #{host}:#{port}") unless response.body == 'Authenticated.'
    end
  end
end
