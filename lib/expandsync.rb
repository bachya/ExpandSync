require "expandsync/cli_message"
require "expandsync/constants"
require "expandsync/exceptions"

module ExpandSync
  #  ====================================================
  #  Methods
  #  ====================================================
  #  ----------------------------------------------------
  #  build_snippets_for_atext method
  #
  #  Builds an CSV string of snippets for insertion into
  #  aText.
  #  @return String
  #  ----------------------------------------------------
  def self.build_csv_for_atext(snippet_array)
    csv_string = CSV.generate do |csv|
      snippet_array.each { |s| csv << [s[0], s[1]] }
    end
    
    csv_string
  end
  
  #  ----------------------------------------------------
  #  build_snippets_for_textexpander method
  #
  #  Builds an XML string of snippets for insertion into
  #  TextExpander.
  #  @param snippet_array An array of snippets to add
  #  @param base_xml The base XML filepath
  #  @return String
  #  ----------------------------------------------------
  def self.build_xml_for_textexpander(snippet_array, base_xml_filepath)
    begin
      existing_xml = Nokogiri::XML(File.open(base_xml_filepath))
    rescue
      raise Exceptions::InvalidXMLError, "Invalid TextExpander XML file: #{ base_xml_filepath }"
    end
    
    xml_builder = Nokogiri::XML::Builder.new do |xml|
      xml.snippets {
        snippet_array.each do |s|
          xml.dict {
            xml.key 'abbreviation'
            xml.string s[0]
            xml.key 'abbreviationMode'
            xml.integer '0'
            xml.key 'creationDate'
            xml.date Time.now.utc.iso8601
            xml.key 'flags'
            xml.integer '0'
            xml.key 'label'
            xml.string
            xml.key 'modificationDate'
            xml.date Time.now.utc.iso8601
            xml.key 'plainText'
            xml.string s[1]
            xml.key 'snippetType'
            xml.integer '0'
            xml.key 'useCount'
            xml.integer '0'
            xml.key 'uuidString'
            xml.string SecureRandom.uuid.upcase
          }
        end
      }
    end
    
    existing_xml.xpath("/*/*/array[preceding-sibling::key[1] = 'snippetsTE2']")[0].add_child(xml_builder.doc.root.children.to_xml)
    existing_xml
  end
  
  #  ----------------------------------------------------
  #  load_atext_snippets method
  #
  #  Loads an aText CSV file and returns the results
  #  @param filepath The path to the aText CSV file
  #  @return Array
  #  ----------------------------------------------------
  def self.load_atext_snippets(filepath)
    begin
      CSV.read(filepath).each { |s| s[2] = 'aText' }
    rescue
      raise Exceptions::InvalidCSVError, "Invalid aText CSV file: #{ filepath }"
    end
  end
  
  #  ----------------------------------------------------
  #  load_textexpander_snippets method
  #
  #  Loads a TextExpander XML file and returns the results
  #  @param filepath The path to the TextExpander XML file
  #  @return Array
  #  ----------------------------------------------------
  def self.load_textexpander_snippets(filepath)
    begin
      snippets = Nokogiri::XML(File.open(filepath)).xpath("/*/*/array[preceding-sibling::key[1] = 'snippetsTE2']/*")
    rescue
      raise Exceptions::InvalidXMLError, "Invalid TextExpander XML file: #{ filepath }"
    end
    
    arr = []
    snippets.each do |snippet|
      abbreviation = snippet.xpath("string[preceding-sibling::key[1] = 'abbreviation']").text
      value = snippet.xpath("string[preceding-sibling::key[1] = 'plainText']").text
      arr << [abbreviation, value, 'TextExpander'] 
    end
    
    arr
  end
end
