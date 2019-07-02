# frozen_string_literal: true

RSpec.describe NilRemoteAd do
  let(:ad) { described_class.new }

  %i[reference status description].each do |attr|
    describe "##{attr}" do
      subject { ad.send(attr) }

      it { is_expected.to eq 'Non Existent' }
    end
  end
end
