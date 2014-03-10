include FileUtils

TMP_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','tmp')

Given(/^an aText CSV file at "(.*?)"$/) do |atext_filepath|
  @atext_input_filepath = File.join(TMP_DIR, 'atext.csv')
  FileUtils.cp(@atext_input_filepath, atext_filepath)
end