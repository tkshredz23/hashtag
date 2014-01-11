require 'spec_helper'

feature 'Guest searches for hashtags' do
  scenario 'searches from homepage' do
    visit root_path
    search_for '#ruby'
    
    expect(page).to have_css '.results li', count: 15, text: /#ruby/i
    expect(current_path).to eq '/searches/ruby'
    expect(search_term_field_value).to eq '#ruby'
  end
  
  scenario 'handles search terms with a hashtag present' do
    visit root_path
    search_for '#ruby'

    expect(page).to have_css '.results li', count: 15, text: /#ruby/i
    expect(current_path).to eq '/searches/ruby'
    expect(search_term_field_value).to eq '#ruby'
  end

  scenario 'allows for searching from the search results page' do
    visit root_path
    search_for '#ruby'
    search_for '#rails'

    expect(page).to have_css '.results li', count: 15, text: /#rails/i
    expect(current_path).to eq '/searches/rails'
    expect(search_term_field_value).to eq '#rails'
  end

  def search_for(term)
    fill_in 'Search term', with: term
    click_on 'Submit'
  end

  def search_term_field_value
    field_labeled('Search term').value
  end
end