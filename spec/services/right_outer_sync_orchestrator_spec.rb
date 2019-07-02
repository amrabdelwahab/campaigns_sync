# frozen_string_literal: true

RSpec.describe RightOuterSyncOrchestrator do
  describe '::call' do
    subject { described_class.call(remote_ads: remote_ads) }

    let(:remote_ad) { instance_double(RemoteAd, reference: '1') }
    let(:remote_ads) { [remote_ad] }
    let(:nil_local_campaign) { instance_double(NilLocalCampaign) }

    let(:right_outer_difference) do
      {
        'reference' => {
          'local' => 'Non Existent',
          'remote' => '1'
        },
        'discrepancies' => [{}]
      }
    end

    before do
      allow(NilLocalCampaign)
        .to receive(:new)
        .with(no_args)
        .and_return(nil_local_campaign)

      allow(CampaignDiscrepanciesDetector)
        .to receive(:call)
        .with(remote_ad: remote_ad, local_campaign: nil_local_campaign)
        .and_return(right_outer_difference)
    end

    it { is_expected.to eq([right_outer_difference]) }
  end
end
