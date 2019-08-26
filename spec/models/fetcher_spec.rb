# require 'byebug'
require_relative '../../app/models/fetcher'

describe Fetcher do
  context 'When testing the Fetcher class' do
    f = Fetcher
    search_results = f.request_search('mac and cheese')
    
    it 'should return search results from the Spoon API for "mac and cheese"' do
      expect(!!search_results).to be true
    end

  end
end
