require 'squib'
require 'csv'

data = Squib.csv file: 'cards.csv'

types = data['Type'].uniq

types.each do |type|
  type_indexes = data['Type'].each_index.select { |i| data['Type'][i] == type }

  Squib::Deck.new(cards: type_indexes.size, width: 825, height: 1125) do
    background color: 'white'

    text str: data['Kind'].values_at(*type_indexes), x: 200, y: 200, font: 'Arial 16', width: 625, align: :center
    text str: data['Build Cost'].values_at(*type_indexes), x: 400, y: 200, font: 'Arial 16', width: 525, align: :center
    text str: data['Crew Cost'].values_at(*type_indexes), x: 100, y: 200, font: 'Arial 16', width: 525, align: :center
    text str: data['Name'].values_at(*type_indexes), x: 200, y: 300, font: 'Arial Bold 18', width: 625, height: 400, wrap: :word_char, align: :center
    text str: data['Type'].values_at(*type_indexes), x: 200, y: 700, font: 'Arial 14', width: 625, align: :center
    text str: data['Subtype'].values_at(*type_indexes), x: 200, y: 800, font: 'Arial 14', width: 625, align: :center
    text str: data['Card Set'].values_at(*type_indexes), x: 200, y: 900, font: 'Arial 12', width: 625, align: :center

    save_sheet prefix: "cards_#{type}_", columns: 4, rows: 4, margin: 0, gap: 0
  end
end