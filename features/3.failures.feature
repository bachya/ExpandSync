Feature: Failures
  As a user, when something goes wrong (either via my
  own doing, or because of something unexpected), I
  should be notified

  Scenario: Run with bad aText Input
    Given a file located at "/tmp/expandsync/input/random-text-file.txt"
    When I run `expandsync /tmp/expandsync/input/random-text-file.txt`
    Then the exit status should be 1  

  Scenario: Run with bad -a flag
    Given a file located at "/tmp/expandsync/input/atext.csv"
    When I run `expandsync -a /asdgsaduatsidtigasd/out.csv /tmp/expandsync/input/atext.csv`
    Then the exit status should be 1