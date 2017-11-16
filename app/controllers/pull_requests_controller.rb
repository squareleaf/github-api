class PullRequestsController < ApplicationController
  def index
    response = HTTParty.get("https://api.github.com/repos/lodash/lodash/pulls?state=all&per_page=100")

    headers = response.headers

    # grab the number of the last page from the link param of the headers hash
    if headers["link"].present?
      index_last_page = headers["link"].rindex('&page=')
      last_page = headers["link"].slice(index_last_page + 6).to_i
    end

    # concatenate results
    @response = []
    for i in 1..last_page
      response = HTTParty.get("https://api.github.com/repos/lodash/lodash/pulls?state=all&page=#{i}&per_page=100")
      @response << response.parsed_response
    end

    @response = @response.flatten
  end
end
