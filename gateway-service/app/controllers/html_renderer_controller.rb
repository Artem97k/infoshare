require 'rails/application_controller'

class HtmlRendererController < Rails::ApplicationController
  def index
    render file: Rails.root.join('public', 'root.html')
  end
end
