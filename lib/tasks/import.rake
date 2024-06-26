namespace :import do
    namespace :all_data do
      desc 'Import all data into the Database from the CSV file ./coaches.csv'
      task from_csv: :environment do
        num_imported = Importer.from_csv("#{Rails.root}/lib/tasks/coaches.csv")
  
        puts '*' * 25
        puts "Imported #{num_imported} CSV rows."
        puts '*' * 25
      end
    end
  end