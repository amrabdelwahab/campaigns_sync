# frozen_string_literal: true

RSpec.describe FileDataSource do
  let(:data_key) { 'data_key' }
  let(:file_name) { 'file_name.json' }
  let(:model_class) { class_double('Model') }

  let(:data_source) do
    described_class.new(
      data_key: data_key,
      file_name: file_name,
      model_class: model_class
    )
  end

  describe '#all' do
    subject { data_source.all }
    let(:item) { { 'attr_1' => 'val_1' } }
    let(:item_object) { double('Item') }
    let(:data) do
      {
        'data_key' => [item]
      }.to_json
    end

    before do
      allow(File)
        .to receive(:open)
        .with('./storage/file_name.json', 'r')
        .and_yield(StringIO.new(data))

      allow(model_class)
        .to receive(:new)
        .with(item)
        .and_return(item_object)
    end

    it { is_expected.to eq [item_object] }
  end
end
