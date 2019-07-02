# frozen_string_literal: true

class CampaignsSync
  def self.call
    new.call
  end

  def call
    local_campaigns
      .map { |campaign| discrepancies(campaign) }
      .compact
  end

  private

  def local_campaigns
    @local_campaigns ||= LocalCampaignsRepository.all
  end

  def discrepancies(campaign)
    CampaignDiscrepanciesDetector.call(
      local_campaign: campaign,
      remote_ad: remote_ad(campaign.external_reference)
    )
  end

  def remote_ad(reference)
    remote_ads.find { |ad| ad.reference == reference } ||
      NilRemoteAd.new
  end

  def remote_ads
    @remote_ads ||= RemoteAdsRepository.all
  end
end
