# News-Getter
[![Build Status](https://travis-ci.org/IIC2113-2015-2-Grupo1/news-getter.svg)](https://travis-ci.org/IIC2113-2015-2-Grupo1/news-getter) [![Code Climate](https://codeclimate.com/github/IIC2113-2015-2-Grupo1/news-getter/badges/gpa.svg)](https://codeclimate.com/github/IIC2113-2015-2-Grupo1/news-getter)

Make sure you have **Ruby 2.2.3** installed.

## Local

### Setup

Install [bundler](http://bundler.io/) and [Nokogiri](http://www.nokogiri.org/):
```sh
$ gem install --no-ri --no-rdoc bundler
$ gem install --no-ri --no-rdoc nokogiri

# if using rbenv
$ rbenv rehash
```

Install gems:
```sh
$ bundle install
```

### Run
```sh
$ rackup --host 0.0.0.0 -p 5000

# Available on:
# http://localhost:5000/
```

### Test
```sh
$ rspec
```

### Metric_FU
```sh
$ rake metrics:all
```

### Development with Docker

```sh
# Build
$ docker build --no-cache --rm --tag=news-getter .

# Run
$ docker run --publish 5000:5000 --rm --name=news-getter news-getter
```
