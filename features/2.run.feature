Feature: Run
  As a user, when I run the app (w/ or w/o flags), I
  should have the correct content be placed in the correct
  files.
      
  Scenario: Run with no flags
    Given a file located at "/tmp/expandsync/input/atext.csv"
    When I successfully run `expandsync /tmp/expandsync/input/atext.csv`
    Then "~/aText-snippets.csv" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander" should exist
      And Settings.textexpander should be backed up

  Scenario: Run with -a flag
    Given a file located at "/tmp/expandsync/input/atext.csv"
    When I run `expandsync -a /tmp/expandsync/output/aText-output.csv /tmp/expandsync/input/atext.csv`
    Then "/tmp/expandsync/output/aText-output.csv" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander" should exist
      And Settings.textexpander should be backed up

  Scenario: Run with -n flags
    Given a file located at "/tmp/expandsync/input/atext.csv" 
    When I successfully run `expandsync -n /tmp/expandsync/input/atext.csv`
    Then "~/aText-snippets.csv" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander" should exist
      And Settings.textexpander should not be backed up
