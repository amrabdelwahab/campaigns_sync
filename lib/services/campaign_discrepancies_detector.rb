# frozen_string_literal: true

class CampaignDiscrepanciesDetector
  ATTRIBUTES_TO_COMPARE = %i[status description].freeze

  def self.call(local_campaign:, remote_ad:)
    new(local_campaign, remote_ad).call
  end

  def initialize(local, remote)
    @local = local
    @remote = remote
  end

  def call
    return if discrepant_attributes.empty?

    formatted_output
  end

  private

  attr_reader :local, :remote

  def discrepant_attributes
    @discrepant_attributes ||= ATTRIBUTES_TO_COMPARE.reject do |attr|
      local.send(attr) == remote.send(attr)
    end
  end

  def formatted_output
    {
      'reference' => formatted_references,
      'discrepancies' => formatted_discrepancies
    }
  end

  def formatted_references
    {
      'local' => local.external_reference,
      'remote' => remote.reference
    }
  end

  def formatted_discrepancies
    discrepant_attributes.map do |attr|
      {
        attr.to_s => {
          'remote' => remote.send(attr),
          'local' => local.send(attr)
        }
      }
    end
  end
end
