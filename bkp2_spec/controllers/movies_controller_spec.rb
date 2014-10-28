require_relative 'rails_helper'

describe MoviesController do
  describe 'search the TMDB' do
    before :each do
      @fake_results = [double('m1'), double('m2')]
    end

    it 'should call the method in model to search in TMDB' do
      Movie.should_receive(:find_in_tmdb).with('haedware').
      and_return(@fake_results)
      post :search_tmdb, {:search_text => {:title => 'hardware'}}
    end

    describe 'on successfull search' do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, {:search_text => {:title => 'hardware'}}
      end

      it 'should take the template for search results and do rendering' do
        response.should render_template('search_tmdb')
      end

      it 'should make availabe TMDB search results to template' do
        assigns(:movies).should == @fake_results
      end
    end
  end

end
