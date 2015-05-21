Uses [@mattsears's Nyan Cat Formatter](https://github.com/mattsears/nyan-cat-formatter)
and code copied from [@tenderlove's minitest-emoji](https://github.com/tenderlove/minitest-emoji).

![](https://raw.githubusercontent.com/tgxworld/minitest-nyan-cat/master/minitest-nyan-cat.gif)

## minitest-nyan-cat

http://github.com/tgxworld/minitest-nyan-cat

### DESCRIPTION:

Prints a Nyan Cat trail for your test output

### INSTALL:

`gem install minitest-nyan-cat`

### SYNOPSIS:

```ruby
  require 'minitest/autorun'
  require 'minitest/nyan_cat'

  describe 'my amazing tests' do
    200.times do |i|
      it "must #{i}" do
        100.must_equal 100
      end
    end

    2.times do |i|
      it "compares #{i} to #{i + 1}" do
        i.must_equal i + 1
      end
    end

    it 'skips things!!' do
      skip "don't care!"
    end
  end
```

### RAILS:

Add `gem 'minitest-nyan-cat', group: :test` to your `Gemfile and run `bundle install`.

Following which, add `require 'minitest/nyan_cat'` to your `test_helper.rb`.
