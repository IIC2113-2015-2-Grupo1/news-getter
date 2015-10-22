# News-Getter
[![Build Status](https://travis-ci.org/IIC2113-2015-2-Grupo1/news-getter.svg)](https://travis-ci.org/IIC2113-2015-2-Grupo1/news-getter) [![Code Climate](https://codeclimate.com/github/IIC2113-2015-2-Grupo1/news-getter/badges/gpa.svg)](https://codeclimate.com/github/IIC2113-2015-2-Grupo1/news-getter)

Make sure you have **Ruby 2.2.3** installed.

## Local

### Setup

Install [bunlder](http://bundler.io/):
```sh
$ gem install --no-ri --no-rdoc bundler

# if using rbenv
$ rbenv rehash
```

Install gems:
```sh
$ bundle install
```

### Run
```sh
$ rackup -p 5000

# Available on:
# http://localhost:5000/
```

### Deployment

```sh
# Build
$ docker build --no-cache --rm --tag=news-getter .

# Run
$ docker run --publish 5000:5000 --rm --name news-getter news-getter

# Push to hub
$ docker tag news-getter iic2113grupo1/news-getter
$ docker push iic2113grupo1/news-getter
```
