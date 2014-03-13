#  ======================================================
#  AText Class
#  ======================================================
class AText
  #  ====================================================
  #  Constants
  #  ====================================================
  OUTPUT_FILENAME = 'aText-snippets.csv'
  OUTPUT_PATH = ENV['HOME']

  #  ====================================================
  #  Attributes
  #  ====================================================
  attr_accessor :output_file, :snippet_csv, :snippets

  #  ====================================================
  #  Methods
  #  ====================================================
  #  ----------------------------------------------------
  #  initialize method
  #
  #  @param csv_filepath The filepath to the aText CSV
  #  @return Void
  #  ----------------------------------------------------
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
    
    begin  
      @snippets = CSV.read(csv_filepath)
    rescue 
      fail "Invalid aText CSV file: #{ csv_filepath }"
    end
  end
  
  #  ----------------------------------------------------
  #  construct_data method
  #
  #  Outputs a CSV listing of the supplied snippets
  #  @param new_snippets The snippet array to use
  #  @return String
  #  ----------------------------------------------------
  def construct_data(new_snippets)
    @snippet_csv = CSV.generate { |csv| new_snippets.each { |s| csv << [s[0], s[1]] } }
  end

  #  ----------------------------------------------------
  #  save method
  #
  #  Saves the current snippets to Settings.textexpander.
  #  @return Void
  #  ----------------------------------------------------
  def save
    File.open(@output_file, 'w') {|f| f.write(@snippet_csv) }
  end
end