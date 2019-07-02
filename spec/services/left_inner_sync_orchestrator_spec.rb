# frozen_string_literal: true

RSpec.describe LeftInnerSyncOrchestrator do
  describe '::call' do
    subject do
      described_class.call(
        local_campaigns: local_campaigns,
        remote_ads: remote_ads
      )
    end

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

    let(:nil_remote_ad) { instance_double(NilRemoteAd) }

    let(:left_outer_difference) do
      {
        'reference' => {
          'local' => '1',
          'remote' => 'Non Existent'
        },
        'discrepancies' => [{}]
      }
    end

    let(:inner_difference) do
      {
        'reference' => {
          'local' => '2',
          'remote' => '2'
        },
        'discrepancies' => [{}]
      }
    end

    before do
      allow(NilRemoteAd)
        .to receive(:new)
        .with(no_args)
        .and_return(nil_remote_ad)

      allow(CampaignDiscrepanciesDetector)
        .to receive(:call)
        .with(remote_ad: nil_remote_ad, local_campaign: outer_campaign)
        .and_return(left_outer_difference)

      allow(CampaignDiscrepanciesDetector)
        .to receive(:call)
        .with(remote_ad: inner_ad, local_campaign: inner_campaign)
        .and_return(inner_difference)
    end

    it { is_expected.to eq([left_outer_difference, inner_difference]) }
  end
end
