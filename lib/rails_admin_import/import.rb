require 'open-uri'
require "rails_admin_import/import_logger"
require 'spreadsheet'

module RailsAdminImport
    module Import
        extend ActiveSupport::Concern

        module ClassMethods
            def run_import(params)
                begin
                    if !params.has_key?(:file)
                        return results = { :success => [], :error => ["You must select a file."] }
                    end

                    if RailsAdminImport.config.logging
                        FileUtils.copy(params[:file].tempfile, "#{Rails.root}/log/import/#{Time.now.strftime("%Y-%m-%d-%H-%M-%S")}-import.csv")
                    end

                    Student.import_all params[:file].tempfile.to_s


                end
            end
        end
    end
end

class ActiveRecord::Base
    include RailsAdminImport::Import
end
