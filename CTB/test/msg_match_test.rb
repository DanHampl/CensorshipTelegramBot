require 'test/unit'
require_relative 'helpers/message'
require_relative '../lib/ctb'

class ConvertorTest < Test::Unit::TestCase
  def test_match_id
    ctb = CTB.new
    config = JSON.parse('[
      {"user_ids": [1, 3]}
    ]')
    msg = Message.new(1, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user id')

    msg = Message.new(2, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by user id')

    msg = Message.new(3, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user id')
  end

  def test_match_name
    ctb = CTB.new
    config = JSON.parse('[
      {"user_names": ["karel", "pepa"]}
    ]')
    msg = Message.new(1, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user name')

    msg = Message.new(1, 'franta', 'some text')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by user name')

    msg = Message.new(1, 'pepa', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user name')
  end

  def test_match_content
    ctb = CTB.new
    config = JSON.parse('[
      {"msg_contains": ["text", "blah"]}
    ]')
    msg = Message.new(1, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by msg content')

    msg = Message.new(1, 'karel', 'some message')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by msg content')
    
    msg = Message.new(1, 'karel', 'blah')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by msg content')
  end

  def test_match_and
    ctb = CTB.new
    config = JSON.parse('[
      {"and": [
        {"user_ids": [1]},
        {"user_names": ["karel"]},
        {"msg_contains": ["text"]}
      ]}
    ]')
    msg = Message.new(1, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user name, id and content')

    msg = Message.new(1, 'karel', 'some message')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by msg content')

    msg = Message.new(1, 'franta', 'some text')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by user name')

    msg = Message.new(2, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by user id')
  end

  def test_match_or
    ctb = CTB.new
    config = JSON.parse('[
      {"or": [
        {"user_ids": [2]},
        {"user_names": ["franta"]},
        {"msg_contains": ["message"]}
      ]}
    ]')
    msg = Message.new(1, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(!result, 'Message should not be matched by user name, id or content')

    msg = Message.new(1, 'karel', 'some message')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by msg content')

    msg = Message.new(1, 'franta', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user name')

    msg = Message.new(2, 'karel', 'some text')
    result = ctb.match_config(msg, config)
    assert(result, 'Message should be matched by user id')
  end
end
