require 'csv'

  business_data_file_path = 'db/fixtures/50k_businesses.csv'
  CSV.foreach(business_data_file_path, headers: true) do |row|
    Business.create! row.to_hash
  end