require 'rails_helper'

# Fix for Rails 4.2 + Ruby 2.6
if RUBY_VERSION >= '2.6.0' && Rails.version < '5'
  class ActionController::TestResponse < ActionDispatch::TestResponse
    def recycle!
      @mon_mutex_owner_object_id = nil
      @mon_mutex = nil
      initialize
    end
  end
end

describe MoviesController, type: :controller do
  describe 'searching TMDb' do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end

    it 'calls the model method that performs TMDb search' do
      allow(Movie).to receive(:find_in_tmdb).with(title: 'hardware').and_return(@fake_results)

      # Rails 4.2 style, no `params:` keyword
      get :search_tmdb, search_terms: 'hardware'

      expect(Movie).to have_received(:find_in_tmdb).with(title: 'hardware')
    end

    describe 'after valid search' do
      before :each do
        allow(Movie).to receive(:find_in_tmdb).with(title: 'hardware').and_return(@fake_results)
        get :search_tmdb, search_terms: 'hardware'
      end

      it 'selects the Search Results template for rendering' do
        expect(response).to render_template('search_tmdb')
      end

      it 'makes the TMDb search results available to that template' do
        expect(assigns(:movies)).to eq(@fake_results)
      end
    end
  end
end
