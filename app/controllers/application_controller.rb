class ApplicationController < ActionController::Base
  # using the sanitize gem
  def sanitize input_field
    Sanitize.fragment(input_field, Sanitize::Config::RELAXED)
  end

  def sanitize_input input_params, fields
    fields.each do |field|
      input_params[field] = sanitize(input_params[field])
    end
  end
end
