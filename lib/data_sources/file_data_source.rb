# frozen_string_literal: true

require 'json'

class FileDataSource
  attr_reader :model_class

  def initialize(data_key:, file_name:, model_class:)
    @data_key = data_key
    @file_name = file_name
    @model_class = model_class
  end

  def all
    content.map do |item|
      model_class.new(item)
    end
  end

  private

  attr_reader :data_key, :file_name

  def content
    JSON.parse(raw_content).fetch(data_key, [])
  end

  def raw_content
    @raw_content ||= File.open("./storage/#{file_name}", 'r', &:read)
  end
end
