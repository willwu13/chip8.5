require 'rails_helper'
require 'webmock/rspec'

describe Movie do
  describe '.find_in_tmdb' do
    it 'calls Faraday GET request' do
      stub_request(:get, /themoviedb.org/).to_return(
        body: { results: [{ "title" => "Hacker", "release_date" => "2020-01-01" }] }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      expect(Faraday).to receive(:get).and_call_original

      Movie.find_in_tmdb(title: "hacker", language: "en")
    end
  end
end
