#  ======================================================
#  AText Class
#  ======================================================
class AText
  attr_accessor :filepath, :snippets

  #  ====================================================
  #  Methods
  #  ====================================================
  #  ----------------------------------------------------
  #  initialize method
  #
  #  @param csv_filepath The filepath to the aText CSV
  #  @return Void
  #  ----------------------------------------------------
  def initialize(csv_filepath)
    begin
      @filepath = csv_filepath
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
    CSV.generate { |csv| new_snippets.each { |s| csv << [s[0], s[1]] } }
  end
end