Feature: UI
  When the user asks for help, he should be presented
  with instructions on how to run the app.

  Scenario: Display help instructions
    When I get help for "expandsync"
    Then the exit status should be 0
    And the banner should be present
    And the banner should include the version
    And the banner should document that this app takes options
    And the banner should document that this app takes options
    And the banner should document that this app's arguments are:
      | atext_file | which is required |
      
  Scenario: Standard run to STDOUT (aText) and default Dropbox location (TextExpander)
    Given an aText CSV file at "/tmp/atext.csv"
    When I successfully run `expandsync /tmp/atext.csv`
    Then the output should contain 'tyvm,Thank you very much!
sig1,"Cheers,

Jane Smith
Senior Vice President
Acme, Inc."
sig2,"Yours sincerely,

Jane Smith
PTA President
Cupertino Elementary School"
sig3,"Best regards,
Jane Smith
Senior Vice President
Acme, Inc."
ttel,415-555-1212
aaddr,"123 Market Street
San Francisco, CA"
ddate,%e %B %Y
sms1,I'm running late. Be there soon.
sms2,Traffic is terrible. I'll be late. Sorry.
sms3,I forgot all about our appointment. Can we reschedule?
",pho",720-854-5753
dnthx,"Dear %filltext:name=person name:width:25%,

Thank you for your generous donation of $%filltext:name=amount:width:4%. We greatly appreciate your help, and will use the funds for %fillpopup:name=popup 4:default=our educational program:our health clinic:general purposes%.

Since we are a non-profit organization, your donation of $%filltext:name=amount:width:4% should be tax-deductible.

Thank you,
"
",enc",<en-todo/> 
",1977j","1977 South Josephine Street
Unit 303
Denver, CO 80210"
",755d","755 South Dexter Street
Apartment 128
Denver, CO 80246"
",ema1",bachya1208@gmail.com
",ema2",bachya1208@googlemail.com
",ema3",aaron.m.bach@gmail.com
",fn",Aaron
",ikp",I'll keep you posted.
",lmk",Let me know if you have any questions.
",ln",Bach
",name",Aaron Bach
",tkvm",Thank you very much!
",twimc","To Whom It May Concern,

"
",tood","【field:Subject】 *【field:Folder type:2 width:0 value:""1. Ticklers
2. Actions
3. Projects
4. Waiting For
5. Someday/Maybe""】 @【field:Context type:2 width:0 value:Home
Personal
Work】"
",end",【date:yyyy-MM-dd】 - 
",ent",<en-todo/> 
",jour",- 【date:long】 at 【time:short】 - 【field:Entry type:1】 @done
",waddr","3012 Huron Street
Denver, CO 80202"
",wema",abach@fourwindsinteractive.com
",wftp",ftp.fourwindsinteractive.com
",wfwi",Four Winds Interactive
",wpho",720-389-3606
",wweb",http://www.fourwindsinteractive.com
",text","data:text/html, <html contenteditable> "
'
      And the new TextExpander rules should be located "~/Dropbox/TextExpander/Settings.textexpander"
    