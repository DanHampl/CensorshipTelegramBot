require_relative 'user'

class Message
  attr_accessor :from, :text

  def initialize(id, name, text)
    @from = User.new(id, name)
    @text = text
  end
end
