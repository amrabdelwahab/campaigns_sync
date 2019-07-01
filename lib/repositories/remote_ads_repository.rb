# frozen_string_literal: true

class RemoteAdsRepository < BaseRepository
  def self.data_source
    # This method here should be changed to fetch data
    # from an API data source.
    # A data source object is responsible for reading data
    # and wrapping it into value objects

    FileDataSource.new(
      file_name: 'remote_ads.json',
      model_class:RemoteAd
    )
  end
end
