require 'socket'

module Srcon
  class Connection
    attr_reader :host, :port, :socket

    # @param [String] host The host the server is listening on
    # @param [Integer] port The port the server is listening on
    def initialize(host, port)
      @host = host
      @port = port

      connect
    end

    private

    def connect
      @socket = TCPSocket.new(host, port)
    end
  end
end
