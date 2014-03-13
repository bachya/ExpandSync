require 'equivalent-xml'

Given(/^an aText CSV file at "(.*?)"$/) do |atext_input|
  Dir.chdir(File.dirname(atext_input)) do
    FileUtils.cp(File.join(RES_DIR, 'atext.csv'), 'atext.csv')
    FileUtils.cp(File.join(RES_DIR, 'expected-new-textexpander.xml'), 'expected-new-textexpander.xml')
    FileUtils.cp(File.join(RES_DIR, 'Settings.textexpander'), '/tmp/expandsync/Dropbox/TextExpander/Settings.textexpander')
  end
end

Then(/^"(.*?)" should exist$/) do |file|
  expect(File).to exist(File.expand_path(file)) 
end