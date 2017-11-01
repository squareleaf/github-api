class PullRequestsController < ApplicationController
  def index
    response = HTTParty.get("https://api.github.com/repos/lodash/lodash/pulls?state=all")

    @response = response.parsed_response
  end
end
