# frozen_string_literal: true

RSpec.describe RemoteAdsRepository do
  describe '::all' do
    subject { described_class.all }
    let(:file_data_source) { instance_double(FileDataSource, all: [remote_ad]) }
    let(:remote_ad) { instance_double(RemoteAd) }

    before do
      allow(FileDataSource)
        .to receive(:new)
        .with(
          data_key: 'ads',
          file_name: 'remote_ads.json',
          model_class: RemoteAd
        )
        .and_return(file_data_source)
    end

    it { is_expected.to eq [remote_ad] }
  end
end
