# frozen_string_literal: true

class NilRemoteAd
  ATTRIBUTES = %i[reference status description].freeze

  def attribute
    'Non Existent'
  end

  ATTRIBUTES.each do |attribute|
    alias_method attribute, :attribute
  end

  private :attribute
end
