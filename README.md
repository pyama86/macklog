# Macklog
[![Build Status](https://travis-ci.org/pyama86/macklog.svg?branch=master)](https://travis-ci.org/pyama86/macklog)

[![Code Climate](https://codeclimate.com/github/pyama86/macklog/badges/gpa.svg)](https://codeclimate.com/github/pyama86/macklog)


mackerelのログ監視プラグインです。
指定したファイルに指定したワードが出力された場合、Criticalアラートを出力します。

## Installation

```ruby
gem install macklog
```

## Usage

### mackerel-agent.conf
```
[plugin.checks.http_fatal_error]
command = "macklog -f /var/log/httpd/error.log -w fatal -i"
```

### options
```
-f : 対象ファイル
-w : 対象キーワード
-i : 大文字小文字を区別しない
```

同じアラートを複数回通知しないために、履歴を/tmpディレクトリ配下のファイルで行っています。
/tmp以外で行う場合は、`export MACKLOG_TMP=/var/tmp`のように環境変数に指定を行って下さい。


## Contributing

1. Fork it ( https://github.com/[my-github-username]/macklog/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
