
# Only define the JSON constant once
TMDB_JSON_RESPONSE = {
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/kqMV9VUrGv9BbmRTOzXKyIraeOG.jpg",
      "id": 716088,
      "original_title": "Sydney 2000 Olympics Opening Ceremony",
      "release_date": "2000-09-15",
      "title": "Sydney 2000 Olympics Opening Ceremony"
    },
    {
      "adult": false,
      "backdrop_path": "/7MMlToGu6JBVtL7myvNQIq0qtIf.jpg",
      "id": 716098,
      "original_title": "Sydney 2000 Olympics Closing Ceremony",
      "release_date": "2000-10-01",
      "title": "Sydney 2000 Olympics Closing Ceremony"
    }
  ]
}.to_json

RSpec.configure do |config|
  config.before(:each) do
    WebMock.reset!  # Clear previous stubs
    stub_request(:get, /api.themoviedb.org/).
      to_return(
        status: 200,
        body: TMDB_JSON_RESPONSE,
        headers: { 'Content-Type' => 'application/json' }
      )
  end
end
