require 'csv'

module ExpandSync
  # AText Class
  class AText
    # The output filename
    OUTPUT_FILENAME = 'aText-snippets.csv'

    # The output filepath
    OUTPUT_PATH = ENV['HOME']

    # Stores the output filepath.
    # @return [String]
    attr_accessor :output_file

    # Stores a CSV string of the snippets.
    # @return [String]
    attr_accessor :snippet_csv

    # Stores an array of snippets.
    # @return [Array]
    attr_accessor :snippets

    # Initialize by loading snippets from an aText CSV.
    # @param [String] csv_filepath The filepath to the aText CSV
    # @return [void]
    def initialize(csv_filepath, custom_output_path)
      if custom_output_path.nil?
        @output_file = File.join(OUTPUT_PATH, OUTPUT_FILENAME)
      else
        if Dir.exists?(File.dirname(custom_output_path))
          @output_file = custom_output_path
        else
          fail "Invalid output directory for aText: #{ custom_output_path }"
        end
      end

      if File.exists?(csv_filepath) && File.extname(csv_filepath) == '.csv'
        begin
          @snippets = CSV.read(csv_filepath)
        rescue
          fail "Could not load CSV from file: #{ csv_filepath }"
        end

        @snippets.each { |s| s[2] = 'aText' }
      else
        fail "Invalid CSV file: #{ csv_filepath }"
      end
    end

    # Outputs a CSV listing of the supplied snippets
    # @param [Array] new_snippets The snippet array to use
    # @return [String]
    def construct_data(new_snippets)
      @snippet_csv = CSV.generate { |csv| new_snippets.each { |s| csv << [s[0], s[1]] } }
    end

    # Saves the current snippets to Settings.textexpander.
    # @return [void]
    def save
      File.open(@output_file, 'w') {|f| f.write(@snippet_csv) }
    end
  end
end