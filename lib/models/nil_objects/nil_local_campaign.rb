# frozen_string_literal: true

class NilLocalCampaign
  ATTRIBUTES = %i[external_reference status description].freeze

  def attribute
    'Non Existent'
  end

  ATTRIBUTES.each do |attribute|
    alias_method attribute, :attribute
  end

  private :attribute
end
