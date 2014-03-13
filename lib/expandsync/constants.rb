module ExpandSync
  # App Info
  DESCRIPTION = 'A command line app that synchronizes text expansion snippets between aText for OS X and TextExpander for iOS'
  SUMMARY = 'An engine for synchronizing snippets from aText on OS X and TextExpander iOS'
  VERSION = '0.1.0'
  
  # Filepaths
  DEFAULT_AT_OUTPUT_PATH = File.join(ENV['HOME'], 'aText-snippets.csv')
  DEFAULT_TE_SNIPPET_PATH = File.join(ENV['HOME'], 'Dropbox', 'TextExpander', 'Settings.textexpander')
end
