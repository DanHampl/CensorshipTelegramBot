Gem::Specification.new do |s|
    s.name        = 'CensorshipTelegramBot'
    s.version     = '0.1.0'
    s.summary     = "Bot for deleting messages according to config provided at startup"
    s.description = "Bot for deleting messages according to config provided at startup"
    s.authors     = ["Daniel Hampl"]
    s.email       = 'daniel@hampl.dev'
    s.files       = ["lib/ctb.rb", "test/msg_match_test.rb", "test/helpers/message.rb", "test/helpers/user.rb", "bin/ctb"]
    s.homepage    =
      'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
    s.license       = 'MIT'
    s.executables   = ['ctb']
    s.add_runtime_dependency 'telegram-bot-ruby'
  end