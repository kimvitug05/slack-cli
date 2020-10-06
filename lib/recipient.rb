class Recipient
  attr_reader :slack_id, :name

  def initialize
    @slack_id = slack_id
    @name = name
  end

  def details
    raise NotImplementedError, 'Implement me in a child class!'
  end

  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end

end
