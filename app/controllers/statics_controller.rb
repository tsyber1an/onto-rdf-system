class StaticsController < ApplicationController
  # GET /statics
  # GET /statics.xml
  def index
    @statistics = Static.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statics }
    end
  end
end
