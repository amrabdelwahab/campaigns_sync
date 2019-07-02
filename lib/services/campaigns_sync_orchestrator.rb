# frozen_string_literal: true

class CampaignsSyncOrchestrator
  def self.call
    new.call
  end

  def call
    (left_inner_discrepancies + right_outer_discrepancies).compact
  end

  private

  def left_inner_discrepancies
    return [] if local_campaigns.empty?

    LeftInnerSyncOrchestrator.call(
      local_campaigns: local_campaigns,
      remote_ads: remote_ads
    )
  end

  def right_outer_discrepancies
    return [] if unmatched_remote_ads.empty?

    RightOuterSyncOrchestrator.call(remote_ads: unmatched_remote_ads)
  end

  def local_campaigns
    @local_campaigns ||= LocalCampaignsRepository.all
  end

  def remote_ads
    @remote_ads ||= RemoteAdsRepository.all
  end

  def unmatched_remote_ads
    @unmatched_remote_ads ||= remote_ads.reject do |ad|
      local_campaigns.map(&:external_reference).include?(ad.reference)
    end
  end
end
