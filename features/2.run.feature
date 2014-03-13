@announce
Feature: Run
  As a user asks, when I run the app (w/ or w/o flags), I
  should have the correct content be placed in the correct
  files.
      
  Scenario: Run with no flags
    Given an aText CSV file at "/tmp/expandsync/input/atext.csv"
    When I successfully run `expandsync /tmp/expandsync/input/atext.csv`
    Then "~/aText-snippets.csv" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander" should exist
      And Settings.textexpander should be backed up

  Scenario: Run with good -a flag
    Given an aText CSV file at "/tmp/expandsync/input/atext.csv"
    When I run `expandsync -a /tmp/expandsync/output/aText-output.csv /tmp/expandsync/input/atext.csv`
    Then "/tmp/expandsync/output/aText-output.csv" should exist
      And "~/Dropbox/TextExpander/Settings.textexpander" should exist
      And Settings.textexpander should be backed up
      
  Scenario: Run with bad -a flag
    Given an aText CSV file at "/tmp/expandsync/input/atext.csv"
    Given a filepath that equals "/tmp/bob/out.csv"
    When I run `expandsync -a /tmp/bob/out.csv /tmp/expandsync/input/atext.csv`
    Then it should fail with
    """
    ---> ERROR: Invalid output directory for aText: /tmp/bob/out.csv
    """