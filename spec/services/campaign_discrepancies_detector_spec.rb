# frozen_string_literal: true

RSpec.describe CampaignDiscrepanciesDetector do
  describe '::call' do
    let(:local_campaign) do
      instance_double(
        LocalCampaign,
        external_reference: 'local_reference',
        status: local_status,
        description: local_description
      )
    end

    let(:remote_ad) do
      instance_double(
        RemoteAd,
        reference: 'remote_reference',
        status: remote_status,
        description: remote_description
      )
    end

    subject do
      described_class.call(
        local_campaign: local_campaign,
        remote_ad: remote_ad
      )
    end

    context 'when there are no discrepancies' do
      let(:local_status) { 'status' }
      let(:remote_status) { 'status' }
      let(:local_description) { 'description' }
      let(:remote_description) { 'description' }

      it { is_expected.to be_nil }
    end

    context 'when there are discrepancies' do
      let(:local_status) { 'status_1' }
      let(:remote_status) { 'status_2' }
      let(:local_description) { 'description_1' }
      let(:remote_description) { 'description_2' }

      let(:expected_output) do
        {
          'reference' => {
            'remote' => 'remote_reference',
            'local' => 'local_reference'
          },
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

      it { is_expected.to eq expected_output }
    end
  end
end
