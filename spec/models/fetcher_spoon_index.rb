# require 'byebug'
require_relative '../../app/models/fetcher'

describe Fetcher do
  context 'When sending "mac and cheese" to spoon/:query' do
    f = Fetcher
    query = 'mac and cheese'
    search_response = f.request_search(query)['results']
    search_results = f.return_search_results(search_response)
    titles = search_response.map { |i| i['title'] }
    images = search_results.values.map { |i| i[:image_url] }

    it 'should return search results' do
      expect(!!search_response).to be true
    end

    it 'should have multiple results' do
      expect(search_response.length).to be > 1
    end

    it 'should have 10 results' do
      expect(search_response.length).to eq(10)
    end

    it 'all results should include a title' do
      expect(titles).to eq( titles.reject{ |i| i == '' } )
    end

    it 'the first result should include a URL to a .jpg' do
      expect(images.first).to include('https://')
      expect(images.first).to include('.jpg')
    end

    it 'all other results should also include jpg URLs' do
      images[1..-1].each do |url|
        expect(url).to include('https://')
        expect(url).to include('.jpg')
      end
    end
  end
end
