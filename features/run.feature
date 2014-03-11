Feature: Run
  When the user runs the app, it should do output
  the correct files in the correct locations
      
  Scenario: Run with no flags
    Given an aText CSV file at "/tmp/atext.csv"
      And a TextExpander XML file at "/tmp/expandsync/Dropbox/TextExpander/Settings.textexpander"
    When I successfully run `expandsync /tmp/atext.csv`
    Then the following files should exist:
        | ~/aText-snippets.csv |