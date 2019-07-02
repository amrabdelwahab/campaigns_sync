# frozen_string_literal: true

class RightOuterSyncOrchestrator
  def self.call(remote_ads:)
    new(remote_ads).call
  end

  attr_reader :remote_ads

  def initialize(remote_ads)
    @remote_ads = remote_ads
  end

  def call
    remote_ads.map { |remote_ad| discrepancies(remote_ad) }
  end

  private

  def discrepancies(remote_ad)
    CampaignDiscrepanciesDetector.call(
      local_campaign: nil_local_campaign,
      remote_ad: remote_ad
    )
  end

  def nil_local_campaign
    @nil_local_campaign ||= NilLocalCampaign.new
  end
end
