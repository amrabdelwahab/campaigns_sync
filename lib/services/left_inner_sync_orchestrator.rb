# frozen_string_literal: true

class LeftInnerSyncOrchestrator
  def self.call(local_campaigns:, remote_ads:)
    new(local_campaigns, remote_ads).call
  end

  attr_reader :local_campaigns, :remote_ads

  def initialize(local_campaigns, remote_ads)
    @local_campaigns = local_campaigns
    @remote_ads = remote_ads
  end

  def call
    local_campaigns.map { |campaign| discrepancies(campaign) }
  end

  private

  def discrepancies(campaign)
    CampaignDiscrepanciesDetector.call(
      local_campaign: campaign,
      remote_ad: remote_ad(campaign.external_reference)
    )
  end

  def remote_ad(reference)
    grouped_remote_ads[reference]&.first || nil_remote_ad
  end

  def grouped_remote_ads
    @grouped_remote_ads ||= remote_ads.group_by(&:reference)
  end

  def nil_remote_ad
    @nil_remote_ad ||= NilRemoteAd.new
  end
end
