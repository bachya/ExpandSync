require 'securerandom'
require 'time'

#  ======================================================
#  TextExpander Class
#  ======================================================
class TextExpander
  attr_accessor :base_xml, :filepath, :snippets

  #  ====================================================
  #  Methods
  #  ====================================================
  #  ----------------------------------------------------
  #  initialize method
  #
  #  @param csv_filepath The filepath to the aText CSV
  #  @return Void
  #  ----------------------------------------------------
  def initialize(xml_filepath)
    begin
      xpath = "/*/*/array[preceding-sibling::key[1] = 'snippetsTE2']/*"
      @filepath = xml_filepath
      @base_xml = Nokogiri::XML(File.open(filepath))

      arr = []
      @base_xml.xpath(xpath).each do |snippet|
        abbreviation = snippet.xpath("string[preceding-sibling::key[1] = 'abbreviation']").text
        value = snippet.xpath("string[preceding-sibling::key[1] = 'plainText']").text
        arr << [abbreviation, value] 
      end
      @snippets = arr
    rescue 
      fail "Invalid TextExpander XML file: #{ xml_filepath }"
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
    
    if @base_xml.xpath(at_group_xpath).empty?
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
      @base_xml.xpath(groups_xpath)[0].add_child(xml_builder.doc.root.to_xml)
      # File.open(File.join(ENV['HOME'], 'Downloads/test.xml'), 'w') { |f| @base_xml.write_xml_to f }
    else
      xml_builder = Nokogiri::XML::Builder.new do |xml|
        xml.array {
          snippet_uuids.each do |u| 
            xml.string u
          end
        }
      end
      
      @base_xml.xpath(at_group_xpath + "/array[preceding-sibling::key[1] = 'snippetUUIDs']")[0].add_child(xml_builder.doc.root.children.to_xml)
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
    
    @base_xml.xpath("/*/*/array[preceding-sibling::key[1] = 'snippetsTE2']")[0].add_child(xml_builder.doc.root.children.to_xml)
    uuids
  end

  #  ----------------------------------------------------
  #  construct_data method
  #
  #  Outputs an XML file with the new snippets added.
  #  @param new_snippets The snippet array to use
  #  @return String
  #  ----------------------------------------------------
  def construct_data(new_snippets)
    snippet_uuids = add_snippets_to_base_xml(new_snippets)
    add_group_to_base_xml(snippet_uuids)
    @base_xml
  end

  private :add_group_to_base_xml, :add_snippets_to_base_xml
end