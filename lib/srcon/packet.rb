module Srcon
  class Packet
    MINIMUM_BYTE_SIZE = 10
    MAXIMUM_BYTE_SIZE = 4096

    # Packet types
    SERVERDATA_AUTH           = 3
    SERVERDATA_AUTH_RESPONSE  = 2
    SERVERDATA_EXECCOMMAND    = 2
    SERVERDATA_RESPONSE_VALUE = 0

    attr_accessor :id, :type
    attr_reader :body

    # @param [String] body The message body for the packet
    def initialize(body = '', type = SERVERDATA_EXECCOMMAND, id = 1)
      @body = body
      @type = type
      @id   = id
    end

    def body=(new_body)
      @body = new_body

      if size > MAXIMUM_BYTE_SIZE
        raise Srcon::MaxPacketSize.new("Maximum packet size is #{MAXIMUM_BYTE_SIZE} bytes")
      end
    end

    def size
      MINIMUM_BYTE_SIZE + body.bytesize
    end

    def to_s
      sizeb = [size].pack('l<')
      idb   = [id].pack('l<')
      typeb = [type].pack('l<')
      bodyb = [body].pack('Z*')

      sizeb + idb + typeb + bodyb + "\0"
    end
  end
end
