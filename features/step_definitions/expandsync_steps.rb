require 'nori'

Given(/^an aText CSV file at "(.*?)"$/) do |atext_input|
  Dir.chdir(File.dirname(atext_input)) do
    FileUtils.cp(File.join(TMP_DIR, 'atext.csv'), 'atext.csv')
    FileUtils.cp(File.join(TMP_DIR, 'expected-new-textexpander.xml'), 'expected-new-textexpander.xml')
    FileUtils.cp(File.join(TMP_DIR, 'Settings.textexpander'), '/tmp/expandsync/Dropbox/TextExpander/Settings.textexpander')
  end
end

Then(/^"(.*?)" should exist$/) do |file|
  expect(File).to exist(File.expand_path(file)) 
end

Then(/^"(.*?)" should be the same as "(.*?)"$/) do |file1, file2|
  parser = Nori.new
  file1_xml = parser.parse(File.read(File.expand_path(file1)))
  file2_xml = parser.parse(File.read(File.expand_path(file2)))
  expect(file1_xml).to eq(file2_xml)
end