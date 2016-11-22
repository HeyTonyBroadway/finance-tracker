class StocksController < ApplicationController
	def search
		if params[:stock]
			@stock = Stock.find_by_ticker(params[:stock])
			@stock ||= Stock.new_from_lookup(params[:stock]) #if we have already looked it up, the stock will be recognized in the instance variable if it hasn't the ||= will happen
		end

		if @stock
			# render json: @stock #would throw a stock object in JSON
			render partial: 'lookup'
		else
			render status: :not_found, nothing: true
		end
	end
end