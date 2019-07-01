# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RemoteAd do
  let(:ad) { described_class.new(raw_data) }
  let(:raw_data) do
    {
      'reference' => '1',
      'status' => 'disabled',
      'description' => 'Description for campaign 11'
    }
  end

  describe '#reference' do
    subject { ad.reference }

    it { is_expected.to eq '1' }
  end

  describe '#status' do
    subject { ad.status }

    it { is_expected.to eq 'disabled' }
  end

  describe '#description' do
    subject { ad.description }

    it { is_expected.to eq 'Description for campaign 11' }
  end
end
