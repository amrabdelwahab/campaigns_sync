# frozen_string_literal: true

RSpec.describe CampaignsSync do
  describe '::call' do
    subject { described_class.call }

    before do
      allow(LocalCampaignsRepository)
        .to receive(:all)
        .with(no_args)
        .and_return(local_campaigns)

      allow(RemoteAdsRepository)
        .to receive(:all)
        .with(no_args)
        .and_return(remote_ads)
    end

    context 'when there are no local or remote campaigns' do
      let(:local_campaigns) { [] }
      let(:remote_ads) { [] }

      it { is_expected.to eq [] }

      it 'does not create any discrepancies matchers' do
        expect(CampaignDiscrepanciesDetector)
          .not_to receive(:call)

        subject
      end
    end

    context 'when there are local campaigns and no remote ads' do
      let(:local_campaigns) { [local_version] }
      let(:remote_ads) { [] }
      let(:local_version) do
        instance_double('LocalCampaign', external_reference: '3')
      end
      let(:nil_remote_ad) { instance_double(NilRemoteAd) }
      let(:difference) do
        {
          'remote_reference' => '3',
          'discrepancies' => [
            {
              'status' => {
                'remote' => 'Non Existent',
                'local' => 'status_1'
              }
            },
            {
              'description' => {
                'remote' => 'Non Existent',
                'local' => 'description_1'
              }
            }
          ]
        }
      end

      before do
        allow(NilRemoteAd)
          .to receive(:new)
          .with(no_args)
          .and_return(nil_remote_ad)

        allow(CampaignDiscrepanciesDetector)
          .to receive(:call)
          .with(local_campaign: local_version, remote_ad: nil_remote_ad)
          .and_return(difference)
          .once
      end

      it 'calls the CampaignDiscrepanciesDetector once' do
        expect(CampaignDiscrepanciesDetector)
          .to receive(:call)
          .with(local_campaign: local_version, remote_ad: nil_remote_ad)
          .once

        subject
      end
    end

    context 'when there are local and remote campaigns' do
      let(:local_campaigns) { [local_version] }
      let(:remote_ads) { [remote_version] }
      let(:local_version) do
        instance_double('LocalCampaign', external_reference: '3')
      end
      let(:remote_version) { instance_double('RemoteAd', reference: '3') }
      let(:difference) { nil }

      before do
        allow(CampaignDiscrepanciesDetector)
          .to receive(:call)
          .with(local_campaign: local_version, remote_ad: remote_version)
          .and_return(difference)
          .once
      end

      it 'calls the CampaignDiscrepanciesDetector once' do
        expect(CampaignDiscrepanciesDetector)
          .to receive(:call)
          .with(local_campaign: local_version, remote_ad: remote_version)
          .once

        subject
      end

      context 'when there are discrapencies' do
        let(:difference) do
          {
            'remote_reference' => '3',
            'discrepancies' => [
              {
                'status' => {
                  'remote' => 'status_2',
                  'local' => 'status_1'
                }
              },
              {
                'description' => {
                  'remote' => 'description_2',
                  'local' => 'description_1'
                }
              }
            ]
          }
        end

        it { is_expected.to eq [difference] }
      end

      context 'when there are no discrapencies' do
        let(:difference) { nil }

        it { is_expected.to eq [] }
      end
    end
  end
end
