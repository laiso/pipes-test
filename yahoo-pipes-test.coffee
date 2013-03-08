assert = require('assert')

describe 'Yahoo! Pipesに登録したパイプの動作監視テスト', ->

  describe 'Apple Developer Center iOS Sample Code Update (http://pipes.yahoo.com/pipes/pipe.info?_id=2e692378a03f70e68eeaefbd75927624 )', ->
    it 'SampleCodeのフィードにitemが20個入って返ってくる', (done) ->
      loadPipes 'http://pipes.yahoo.com/pipes/pipe.run?_id=2e692378a03f70e68eeaefbd75927624&_render=rss', (items) ->
        assert items.length is 20
        done()

  describe 'Apple Developer Center iOS Documentation Update (http://pipes.yahoo.com/pipes/pipe.info?_id=265d351456e157e65ba1df00baf8c10d )', ->
    it 'Dcoument Updateのフィードにitemが20個入って返ってくる', (done) ->
      loadPipes 'http://pipes.yahoo.com/pipes/pipe.run?_id=265d351456e157e65ba1df00baf8c10d&_render=rss', (items) ->
        assert items.length is 20
        done()

  describe 'TwitterUserFeed (http://pipes.yahoo.com/laiso/twitter_user_feed )', ->
    it '@nodejsのフィードにitemが20個入って返ってくる', (done) ->
      loadPipes 'http://pipes.yahoo.com/pipes/pipe.run?_id=c2e8fd12a3c7c90294be218f5d906466&_render=rss&screen_name=nodejs', (items) ->
        assert items.length is 20
        done()


# helpers
request= require('request')
cheerio = require('cheerio')

loadPipes = (url, next) ->
  request url, (error, response, body) ->
    if (!error && response.statusCode == 200)
      $ = cheerio.load body
      next $('item')