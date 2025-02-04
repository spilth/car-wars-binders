require 'squib'
require 'csv'

data = Squib.csv file: 'cards.csv'

types = data['Type'].uniq

types.each do |type|
  type_indexes = data['Type'].each_index.select { |i| data['Type'][i] == type }

  Squib::Deck.new(cards: type_indexes.size, width: 825, height: 1125) do
    background color: 'white'
    # rect width: 825, height: 1125, stroke_color: 'black'

    text str: data['Type'].values_at(*type_indexes), x: 100, y: 300, font: 'Arial 16', width: 625, align: :center
    text str: data['Cost'].values_at(*type_indexes), x: 100, y: 500, font: 'Arial 16', width: 625, align: :center
    text str: data['Name'].values_at(*type_indexes), x: 100, y: 700, font: 'Arial 16', width: 625, height: 400, wrap: :word_char, align: :center

    save_sheet prefix: "cards_#{type}_", columns: 4, rows: 4, margin: 20, gap: 3
  end
end