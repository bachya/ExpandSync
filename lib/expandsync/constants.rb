module ExpandSync
  # App Info
  DESCRIPTION = 'An engine for synchronizing snippets from aText on OS X and TextExpander iOS'
  VERSION = '0.1.0'
  
  # Filepaths
  DEFAULT_AT_SNIPPET_PATH = File.join(ENV['HOME'], 'aText.csv')
  DEFAULT_TE_SNIPPET_PATH = File.join(ENV['HOME'], 'Dropbox', 'TextExpander', 'Settings.textexpander')
end
