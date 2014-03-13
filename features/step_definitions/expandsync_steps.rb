require 'equivalent-xml'

TE_FOLDER = '/tmp/expandsync/Dropbox/TextExpander'

Given(/^an aText CSV file at "(.*?)"$/) do |atext_input|
  Dir.chdir(File.dirname(atext_input)) do
    FileUtils.cp(File.join(RES_DIR, 'atext.csv'), 'atext.csv')
    FileUtils.cp(File.join(RES_DIR, 'expected-new-textexpander.xml'), 'expected-new-textexpander.xml')
    FileUtils.cp(File.join(RES_DIR, 'Settings.textexpander'), TE_FOLDER)
  end
end

Given(/^a filepath that equals "(.*?)"$/) do |filepath|
  @current_filepath = filepath
end

Then(/^"(.*?)" should exist$/) do |file|
  expect(File).to exist(File.expand_path(file)) 
end

Then(/^Settings\.textexpander should be backed up$/) do
  expect(File).to exist(File.join(TE_FOLDER, "Settings.textexpander_#{ Time.now.utc.iso8601 }"))
end

Then(/^it should fail with$/) do |string|
  expect(string).to eq("---> ERROR: Invalid output directory for aText: #{ @current_filepath }")
end