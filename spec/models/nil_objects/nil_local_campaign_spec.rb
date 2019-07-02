# frozen_string_literal: true

RSpec.describe NilLocalCampaign do
  let(:campaign) { described_class.new }

  %i[external_reference status description].each do |attr|
    describe "##{attr}" do
      subject { campaign.send(attr) }

      it { is_expected.to eq 'Non Existent' }
    end
  end
end
