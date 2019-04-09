class Admin::GraphqlsController < ApplicationController

  def create
    query_string = params[:query]
    query_variables = JSON.load(params[:variables]) || {}
    context = { current_user: current_user }
    result = Schema.execute(query_string, variables: query_variables, context: context)
    render json: result
  end

  # def create
  #   query_string = params[:query]
  #   query_variables = JSON.load(params[:variables]) || {}
  #   context = { current_user: current_user }
  #   result = Schema.execute(query_string, variables: query_variables, context: context)
  #   render json: result
  # end
end
