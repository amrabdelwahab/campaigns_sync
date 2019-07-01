# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LocalCampaignsRepository do
  describe '::all' do
    subject { described_class.all }
    let(:file_data_source) { instance_double(FileDataSource, all: [local_campaign]) }
    let(:local_campaign) { instance_double(LocalCampaign) }

    before do
      allow(FileDataSource)
        .to receive(:new)
        .with(file_name: 'local_campaigns.json', model_class: LocalCampaign)
        .and_return(file_data_source)
    end

    it { is_expected.to eq [local_campaign] }
  end
end
