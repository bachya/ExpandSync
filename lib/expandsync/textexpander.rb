require 'securerandom'
require 'time'

#  ======================================================
#  TextExpander Class
#  ======================================================
class TextExpander
  #  ====================================================
  #  Constants
  #  ====================================================
  OUTPUT_FILENAME = 'Settings.textexpander'
  OUTPUT_PATH = File.join(ENV['HOME'], 'Dropbox', 'TextExpander')

  #  ====================================================
  #  Attributes
  #  ====================================================
  attr_accessor :base_xml, :output_file, :snippet_xml, :snippets

  #  ====================================================
  #  Methods
  #  ====================================================
  #  ----------------------------------------------------
  #  initialize method
  #
  #  @param csv_filepath The filepath to the aText CSV
  #  @return Void
  #  ----------------------------------------------------
  def initialize
    begin
      xpath = "/*/*/array[preceding-sibling::key[1] = 'snippetsTE2']/*"
      @output_file = File.join(OUTPUT_PATH, OUTPUT_FILENAME)
      @base_xml = Nokogiri::XML(File.open(@output_file))
      @snippet_xml = @base_xml

      arr = []
      @base_xml.xpath(xpath).each do |snippet|
        abbreviation = snippet.xpath("string[preceding-sibling::key[1] = 'abbreviation']").text
        value = snippet.xpath("string[preceding-sibling::key[1] = 'plainText']").text
        arr << [abbreviation, value] 
      end
      @snippets = arr
    rescue 
      fail "Invalid TextExpander XML file: #{ @output_file }"
    end
  end

  #  ----------------------------------------------------
  #  add_groups_to_base_xml method
  #
  #  Creates correct group information for the provided
  #  snippets.
  #  @param snippets An array of snippets to add
  #  @return Void
  #  ----------------------------------------------------
  def add_group_to_base_xml(snippet_uuids)
    groups_xpath = "/*/*/array[preceding-sibling::key[1] = 'groupsTE2']"
    at_group_xpath = groups_xpath + "/*[string[preceding-sibling::key[1] = 'name'] = 'aText']"
    
    if @snippet_xml.xpath(at_group_xpath).empty?
      xml_builder = Nokogiri::XML::Builder.new do |xml|
        xml.dict {
          xml.key 'expandAfterMode'
          xml.integer '0'
          xml.key 'expanderExceptionsMode'
          xml.integer '4'
          xml.key 'name'
          xml.string 'aText'
          xml.key 'snippetUUIDs'
          xml.array {
            snippet_uuids.each do |u| 
              xml.string u
            end
          }
          xml.key 'suggestAbbreviations'
          xml.integer '1'
          xml.key 'updateFrequency'
          xml.integer '0'
          xml.key 'uuidString'
          xml.string SecureRandom.uuid.upcase
          xml.key 'writable'
          xml.integer '1'
        }
      end
      @snippet_xml.xpath(groups_xpath)[0].add_child(xml_builder.doc.root.to_xml)
    else
      xml_builder = Nokogiri::XML::Builder.new do |xml|
        xml.array {
          snippet_uuids.each do |uuid| 
            xml.string uuid
          end
        }
      end
      
      @snippet_xml.xpath(at_group_xpath + "/array[preceding-sibling::key[1] = 'snippetUUIDs']")[0].add_child(xml_builder.doc.root.children.to_xml)
    end
  end

  #  ----------------------------------------------------
  #  add_snippets_to_base_xml method
  #
  #  Inserts XML for the provided snippets to the base XML
  #  @param snippets An array of snippets to add and returns
  #  an array of snippet UUIDs
  #  @return Void
  #  ----------------------------------------------------
  def add_snippets_to_base_xml(snippets)
    uuids = []

    xml_builder = Nokogiri::XML::Builder.new do |xml|
      xml.snippets {
        snippets.each do |s|
          uuid = SecureRandom.uuid.upcase
          uuids << uuid
          
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
            xml.string uuid
          }
        end
      }
    end
    
    @snippet_xml.xpath("/*/*/array[preceding-sibling::key[1] = 'snippetsTE2']")[0].add_child(xml_builder.doc.root.children.to_xml)
    uuids
  end

  #  ----------------------------------------------------
  #  backup method
  #
  #  Backs up the current TextExpander settings to a
  #  timestamped file in the same directory. Returns
  #  the path to the file created.
  #  @return String
  #  ----------------------------------------------------
  def backup
    dest_filepath = @output_file + "_#{ Time.now.utc.iso8601 }"
    FileUtils.cp(@output_file, dest_filepath)
    dest_filepath
  end

  #  ----------------------------------------------------
  #  construct_data method
  #
  #  Outputs an XML file with the new snippets added.
  #  @param new_snippets The snippet array to use
  #  @return Void
  #  ----------------------------------------------------
  def construct_data(new_snippets)
    snippet_uuids = add_snippets_to_base_xml(new_snippets)
    add_group_to_base_xml(snippet_uuids)
  end

  #  ----------------------------------------------------
  #  save method
  #
  #  Saves the current snippets to Settings.textexpander.
  #  @return Void
  #  ----------------------------------------------------
  def save
    File.open(@output_file, 'w') {|f| f.write(@snippet_xml) }
  end

  private :add_group_to_base_xml, :add_snippets_to_base_xml
end