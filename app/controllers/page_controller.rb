require 'DB'

class PageController < ApplicationController
  def show
    #empty string needed for the root path
    path = params[:path] || ''

    begin
      current_page = DB.find_page_by_path path

      @data = {current_page: current_page}
    rescue
      # raise ActionController::RoutingError.new('Not Found')
    end
  end
end
