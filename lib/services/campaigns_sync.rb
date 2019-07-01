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

  def discrepancies(campaign)
    CampaignDiscrepanciesDetector.call(
      local_campaign: campaign,
      remote_ad: remote(campaign)
    )
  end

  def remote(campaign)
    grouped_remote_ads[campaign.external_reference].first
  end

  def local_campaigns
    @local_campaigns ||= LocalCampaignsRepository.all
  end

  def grouped_remote_ads
    @grouped_remote_ads ||= remote_ads.group_by(&:reference)
  end

  def remote_ads
    @remote_ads ||= RemoteAdsRepository.all
  end
end
