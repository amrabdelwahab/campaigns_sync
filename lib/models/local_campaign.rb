# frozen_string_literal: true

class LocalCampaign
  attr_reader :raw_data

  def initialize(raw_data)
    @raw_data = raw_data
  end

  def external_reference
    raw_data['external_reference']
  end

  def status
    raw_data['status']
  end

  def description
    raw_data['ad_description']
  end
end
