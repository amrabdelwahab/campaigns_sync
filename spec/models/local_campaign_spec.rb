# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LocalCampaign do
  let(:campaign) { described_class.new(raw_data) }
  let(:raw_data) do
    {
      'id' => 111,
      'job_id' => 999,
      'external_reference' => '1',
      'status' => 'disabled',
      'ad_description' => 'Description for campaign 11'
    }
  end

  describe '#external_reference' do
    subject { campaign.external_reference }

    it { is_expected.to eq '1' }
  end

  describe '#status' do
    subject { campaign.status }

    it { is_expected.to eq 'disabled' }
  end

  describe '#description' do
    subject { campaign.description }

    it { is_expected.to eq 'Description for campaign 11' }
  end
end
