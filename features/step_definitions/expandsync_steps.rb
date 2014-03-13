Given(/^a file located at "(.*?)"$/) do |filepath|
  expect(File).to exist(File.expand_path(filepath))
end

Given(/^a variable that equals "(.*?)"$/) do |filepath|
  @variable = filepath
end

Then(/^"(.*?)" should exist$/) do |file|
  expect(File).to exist(File.expand_path(file)) 
end

Then(/^Settings\.textexpander should be backed up$/) do
  expect(File).to exist("/tmp/expandsync/Dropbox/TextExpander/Settings.textexpander_#{ Time.now.utc.iso8601 }")
end

Then(/^Settings\.textexpander should not be backed up$/) do
  expect(File).to_not exist("/tmp/expandsync/Dropbox/TextExpander/Settings.textexpander_#{ Time.now.utc.iso8601 }")
end