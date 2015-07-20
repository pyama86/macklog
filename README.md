# Maltch
[![Build Status](https://travis-ci.org/pyama86/maltch.svg?branch=master)](https://travis-ci.org/pyama86/maltch)

[![Code Climate](https://codeclimate.com/github/pyama86/maltch/badges/gpa.svg)](https://codeclimate.com/github/pyama86/maltch)


mackerelのログ監視プラグインです。
指定したファイルに指定したワードが出力された場合、Criticalアラートを出力します。

## Installation

```ruby
gem 'maltch'
```

## Usage

### mackerel-agent.conf
```
[plugin.checks.http_fatal_error]
command = "maltch -f /var/log/httpd/error.log -w fatal -i"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/maltch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
