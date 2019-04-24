# Simple::Lazy

lazily load objects

## installation

    $ gem install simple-lazy

**or**

```ruby
gem 'simple-lazy'
```

    $ bundle

## usage

```ruby
user = Simple::Lazy.new(1) { |id| User.find(id) } # #<Lazy @value=1 cached?=false>
user.value # => 1
user.cached? # => false
user.username # => "elonmusk"
user.tweets.count # => 7419
user.value # => 1
user.cached? # => true
user.inspect # => #<Lazy @value=1 cached?=false>
user.to_s # => "@elonmusk"
```
