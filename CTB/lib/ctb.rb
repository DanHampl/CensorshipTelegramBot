require 'telegram/bot'

class CTB
  def run(argv = [])
    if argv.length != 2
      print_help
      return
    end

    file = File.open(argv[1], 'r')
    @config = JSON.parse(file.read)
    @token = argv[0]

    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        next unless message.is_a?(Telegram::Bot::Types::Message)

        should_delete = match_config(message, @config)
        if should_delete
          bot.api.delete_message(chat_id: message.chat.id, message_id: message.message_id)
        end
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        end
      end
    end
  end

  def print_help
    puts 'Usage: ctb.rb [options] <token> <pathToConfig>'
    puts 'Options:'
    puts '  -h, --help'
    puts ''
    puts 'Examples:'
    puts '  ruby ctb.rb 110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw ./config.json'
    puts ''
    puts 'You can acquire your token here: https://core.telegram.org/bots#6-botfather'
  end

  def match_config(message, config, type='and')
    case type
    when 'and'
      config.each do |conditions|
        conditions.each do |key, value|
          return false unless match_config(message, value, key)
        end
      end
      return true

    when 'or'
      config.each do |conditions|
        conditions.each do |key, value|
          return true if match_config(message, value, key)
        end
      end
      return false

    when 'user_ids'
      config.each do |value|
        return true if value == message.from.id
      end
      return false

    when 'user_names'
      config.each do |value|
        return true if value == message.from.username
      end
      return false

    when 'msg_contains'
      config.each do |value|
        return true if !message.text.nil? && message.text.include?(value)
      end
      return false
    end
  end
end
