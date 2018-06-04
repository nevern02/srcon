# Srcon

Srcon is a Ruby implementation of Valve's [Source RCON Protocol](https://developer.valvesoftware.com/wiki/Source_RCON_Protocol). It is a TCP-based protocol used for communicating with [Source Dedicated Servers](https://developer.valvesoftware.com/wiki/Source_Dedicated_Server) typically accessible via Steam.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'srcon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install srcon

## Usage

```ruby
require 'srcon'

connection = Srcon::Connection.new('123.45.67.8', 28717, 'some_password')
connection.send('help')
connection.receive
```


## Development

1. Fork the repository.
2. Create a new branch.
3. Make sure tests pass.
4. Open a pull request.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nevern02/srcon.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
