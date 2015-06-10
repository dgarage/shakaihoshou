require 'roo'

desc "Transfers the comparison data that Kikuchisan collected into the db"

task :transfer_comparison_data => :environment do
	p 'Transfering data from excel file to database'
  xlsx = Roo::Spreadsheet.open('db/comparison_data.xlsx')
  (11..82).each do |i|
    row = xlsx.sheet("認可保育園保育料表_東京23区比較").row(i)
    new_data = Comparison.new

    new_data.column_1 = row[0].to_i
    new_data.column_2 = row[1]
    new_data.column_3 = row[2].to_i
    new_data.column_4 = row[3]
    new_data.column_5 = row[4]

    new_data.block_1_1 = row[5]
    new_data.block_1_2 = row[6]
    new_data.block_1_3 = row[7]
    new_data.block_1_4 = row[8]

    new_data.block_2_1 = row[9]
    new_data.block_2_2 = row[10]
    new_data.block_2_3 = row[11]
    new_data.block_2_4 = row[12]

    new_data.block_3_1 = row[13]
    new_data.block_3_2 = row[14]
    new_data.block_3_3 = row[15]
    new_data.block_3_4 = row[16]

    new_data.block_4_1 = row[17]
    new_data.block_4_2 = row[18]
    new_data.block_4_3 = row[19]
    new_data.block_4_4 = row[20]

    new_data.block_5_1 = row[21]
    new_data.block_5_2 = row[22]
    new_data.block_5_3 = row[23]
    new_data.block_5_4 = row[24]

    new_data.block_6_1 = row[25]
    new_data.block_6_2 = row[26]
    new_data.block_6_3 = row[27]
    new_data.block_6_4 = row[28]

    new_data.endcolumn_1 = row[29].to_i
    new_data.endcolumn_2 = row[30]
    new_data.endcolumn_3 = row[31]
    new_data.endcolumn_4 = row[32]

    new_data.extracolumn_1 = row[33]
    new_data.extracolumn_2 = row[34]
    new_data.extracolumn_3 = row[35]
    new_data.extracolumn_4 = row[36]
    new_data.extracolumn_5 = row[37]
    new_data.extracolumn_6 = row[38]
    new_data.extracolumn_7 = row[39]
    new_data.extracolumn_8 = row[40]
    new_data.extracolumn_9 = row[41]
    new_data.extracolumn_10 = row[42]
    new_data.extracolumn_11 = row[43]
    new_data.extracolumn_12 = row[44]
    new_data.extracolumn_13 = row[45]
    new_data.extracolumn_14 = row[46]
    new_data.extracolumn_15 = row[47]
    new_data.extracolumn_16 = row[48]
    new_data.extracolumn_17 = row[49]
    new_data.extracolumn_18 = row[50]
    new_data.extracolumn_19 = row[51]
    new_data.extracolumn_20 = row[52]
    new_data.extracolumn_21 = row[53]

    new_data.last_column = row[54]
    if !Comparison.find_by column_1: row[0].to_i
      new_data.save
    end
  end
end
