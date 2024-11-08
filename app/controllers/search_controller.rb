class SearchController < ApplicationController
  def search
    search = Search.new(start_date: search_params[:start_date], end_date: search_params[:end_date])
    if search.valid?
      @search_results = search.results(current_user)
      respond_to do |format|
        format.turbo_stream { render :search, locals: { results: @search_results, search: search } }
      end
    else
      redirect_to root_path, notice: search.errors.messages
    end
  end

  private

  def search_params
    params.require(:search).permit(:start_date, :end_date)
  end
end
