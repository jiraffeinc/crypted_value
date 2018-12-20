# crypted_value

crypted_value provides bcrypt compare value.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crypted_value'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crypted_value

## Usage

```ruby
v1 = CryptedValue.new("ATSUSHI YOSHIDA")
v1.to_s #=> "$2a$11$QsqgvMOGbH0CcUHVzSifKevmAlycAsN5zIdaQQBIg7kkmZNOrc27y"
v2 = CryptedValue.new("$2a$11$QsqgvMOGbH0CcUHVzSifKevmAlycAsN5zIdaQQBIg7kkmZNOrc27y")
v2 == "ATSUSHI YOSHIDA" #=> true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jiraffeinc/crypted_value.
