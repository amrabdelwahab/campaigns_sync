# frozen_string_literal: true

class LocalCampaignsRepository < BaseRepository
  def self.data_source
    # This method here should be changed to fetch data
    # from a database data source.
    # A data source object is responsible for reading data
    # and wrapping it into value objects
    # In this case, imagine replacing the file datasource
    # with just an active records model Campaign

    FileDataSource.new(
      data_key: 'campaigns',
      file_name: 'local_campaigns.json',
      model_class: LocalCampaign
    )
  end
end
