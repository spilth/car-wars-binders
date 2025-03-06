require 'squib'
require 'csv'

data = Squib.csv file: 'cards.csv'

types = data['Type'].uniq

types.each do |type|
  type_indexes = data['Type'].each_index.select { |i| data['Type'][i] == type }

  Squib::Deck.new(cards: type_indexes.size, width: 825, height: 1125) do
    background color: 'white'

    name_alignments = data['Kind'].values_at(*type_indexes).map { |t| t == "Build" ? :left : :right }
    name_x = data['Kind'].values_at(*type_indexes).map { |t| t == "Build" ? 100 : 200 }

    text str: data['Build Cost'].values_at(*type_indexes), x: 100, y: 100, font: 'Arial 20', width: 625, align: :right
    text str: data['Crew Cost'].values_at(*type_indexes), x: 100, y: 100, font: 'Arial 20', width: 625, align: :left
    text str: data['Name'].values_at(*type_indexes), x: name_x, y: 50, font: 'Arial 14', width: 525, height: 250, wrap: :word_char, align: name_alignments, valign: :bottom
    text str: data['Type'].values_at(*type_indexes), x: 100, y: 300, font: 'Arial 10', width: 625, align: name_alignments
    text str: data['Card Set'].values_at(*type_indexes), x: 100, y: 1000, font: 'Arial 10', width: 625, height: 400, wrap: :word_char, align: :right

    save_sheet prefix: "cards_#{type}_", columns: 4, rows: 4, margin: 20, gap: 3
  end
end