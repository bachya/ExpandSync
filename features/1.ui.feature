Feature: UI
  When the user asks for help, he should be presented
  with instructions on how to run the app.

  Scenario: Display help instructions
    When I get help for "expandsync"
    Then the exit status should be 0
      And the banner should be present
      And the banner should include the version
      And the banner should document that this app takes options
      And the banner should document that this app's arguments are:
        | atext_file | which is required |
      And the following options should be documented:
            | -a        |
            | -n        |
            | -t        |
            | -v        |
            | --verbose |