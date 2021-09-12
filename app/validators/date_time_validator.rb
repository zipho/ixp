# frozen_string_literal: true

class DateTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if begin
      DateTime.parse(value)
    rescue
      ArgumentError
    end == ArgumentError
      ActiveModel::Errors # add(' must be a valid datetime')
    end
  end
end
