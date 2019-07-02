# frozen_string_literal: true

RSpec.describe CampaignsSyncOrchestrator do
  describe '::call' do
    subject { described_class.call }

    let(:outer_campaign) do
      instance_double(LocalCampaign, external_reference: '1')
    end

    let(:inner_campaign) do
      instance_double(LocalCampaign, external_reference: '2')
    end

    let(:inner_ad) { instance_double(RemoteAd, reference: '2') }
    let(:outer_ad) { instance_double(RemoteAd, reference: '3') }
    let(:local_campaigns) { [outer_campaign, inner_campaign] }
    let(:remote_ads) { [outer_ad, inner_ad] }

    let(:left_inner_difference) do
      [
        {
          'reference' => {
            'local' => '1',
            'remote' => 'Non Existent'
          },
          'discrepancies' => [{}]
        },
        {
          'reference' => {
            'local' => '2',
            'remote' => '2'
          },
          'discrepancies' => [{}]
        }
      ]
    end

    let(:right_outer_difference) do
      [
        {
          'reference' => {
            'local' => 'Non Existent',
            'remote' => '3'
          },
          'discrepancies' => [{}]
        }
      ]
    end

    before do
      allow(LocalCampaignsRepository)
        .to receive(:all)
        .with(no_args)
        .and_return(local_campaigns)

      allow(RemoteAdsRepository)
        .to receive(:all)
        .with(no_args)
        .and_return(remote_ads)

      allow(LeftInnerSyncOrchestrator)
        .to receive(:call)
        .with(remote_ads: remote_ads, local_campaigns: local_campaigns)
        .and_return(left_inner_difference)

      allow(RightOuterSyncOrchestrator)
        .to receive(:call)
        .with(remote_ads: [outer_ad])
        .and_return(right_outer_difference)
    end

    it { is_expected.to eq(left_inner_difference + right_outer_difference) }
  end
end
