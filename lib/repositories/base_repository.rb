# frozen_string_literal: true

class BaseRepository
  def self.all
    new(data_source: data_source).all
  end

  attr_reader :data_source

  def initialize(data_source:)
    @data_source = data_source
  end

  def all
    data_source.all
  end
end
