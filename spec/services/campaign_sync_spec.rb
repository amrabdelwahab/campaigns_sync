# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CampaignSync do
  describe '::call' do
    subject { described_class.call }

    it { is_expected.to eq [] }
  end
end
