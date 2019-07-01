# frozen_string_literal: true

class RemoteAd
  attr_reader :raw_data

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def reference
    raw_data['reference']
  end

  def status
    raw_data['status']
  end

  def description
    raw_data['description']
  end
end
