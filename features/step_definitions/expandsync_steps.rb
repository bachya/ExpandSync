Given(/^a file located at "(.*?)"$/) do |filepath|
  expect(File).to exist(File.expand_path(filepath))
end

Then(/^"(.*?)" should exist$/) do |file|
  expect(File).to exist(File.expand_path(file)) 
end

Then(/^Settings\.textexpander should be backed up$/) do
  expect(Dir['/tmp/expandsync/Dropbox/TextExpander/*'].count).to eq(2)
end

Then(/^Settings\.textexpander should not be backed up$/) do
  expect(Dir['/tmp/expandsync/Dropbox/TextExpander/*'].count).to eq(1)
end