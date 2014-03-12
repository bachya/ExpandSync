Feature: Run
  The user runs the app and it outputs
  the correct files in the correct locations
      
  Scenario: Run with no flags
    Given an aText CSV file at "/tmp/atext.csv"
    When I successfully run `expandsync /tmp/atext.csv`
    Then "~/aText-snippets.csv" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander.bak" should exist
