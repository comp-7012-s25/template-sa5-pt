# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'albums/index.html.erb' do
  before do
    assign :albums, build_stubbed_list(:album, 2)

    allow(view).to receive(:link_to).and_call_original
    allow(view).to receive(:button_to).and_call_original
    allow(view).to receive(:album_path).and_call_original
    allow(view).to receive(:new_album_path).and_call_original
    allow(view).to receive(:edit_album_path).and_call_original

    render
  end

  it 'uses link_to helper for links' do
    expect(view).to have_received(:link_to).exactly(5).times
  end

  it 'uses button_to helper for links' do
    expect(view).to have_received(:button_to).exactly(2).times
  end

  it 'uses appropriate route helper(s)' do
    expect(view).to have_received(:album_path).exactly(4).times
    expect(view).to have_received(:new_album_path).exactly(1).times
    expect(view).to have_received(:edit_album_path).exactly(2).times
  end

  it 'has properly closed HTML tags' do
    %w[h1 h2 h3 h4 h5 h6 p a div span ul ol li b i strong table thead tbody tr th td].each do |tag|
      expect(rendered.scan(/<#{tag}[ >]/).size).to eq(rendered.scan("</#{tag}>").size), -> { "check #{tag} tags" }
    end
  end

  it 'does not duplicate elements from layout' do
    %w[head style body].each do |el|
      expect(rendered.scan(/<#{el}[ >]/).size).to eq(0)
    end
  end

  it 'has only the required elements and text' do
    page_elements = Nokogiri::HTML.parse(rendered).search('*').map(&:name)
    # pp page_elements
    expect(page_elements).to eq %w[html body h1 div table thead tr th th th tbody tr td td td a a form input button tr
                                   td td td a a form input button p a]
    page_text = Nokogiri::HTML.parse(rendered).text.gsub(/\s+/, '')
    # pp page_text
    expect(page_text).to eq 'AlbumsTitleArtistmyalbummyartistShow|Edit|DeletemyalbummyartistShow|Edit|DeleteNewAlbum'
  end
end
