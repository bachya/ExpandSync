ExpandSync [![Build Status](https://travis-ci.org/bachya/ExpandSync.png?branch=master)](https://travis-ci.org/bachya/ExpandSync)
==========

A simple engine to sync snippets between aText and TextExpander iOS. Because these two programs don't natively sync, it becomes necessary to introduce a tool that helps grease the skids, so to speak.

# Prerequisites

* Install Ruby 1.9.3 or greater on the machine that will run ExpandSync.
* Enable Dropbox syncing in TextExpander iOS.

# Installation

    $ gem install expandsync
  
# Usage

Syntax and usage can be accessed by running `expandsync --help`:

```
$ expandsync --help
Usage: expandsync [options] atext_filepath

A command line app that synchronizes text expansion snippets between aText for OS X and TextExpander for iOS

v0.1.2

Options:
    -h, --help                       Show command line help
        --version                    Show help/version info
    -a FILEPATH                      Output location for aText rules (defaults to ~/aText-snippets.csv)
    -n                               Disable backing up of Settings.textexpander (RUN AT YOUR OWN RISK!)
    -v, --verbose                    Turn on verbose output

Arguments:

    atext_filepath
        The filepath to a CSV file exported from aText
```

# Process

Synchronizing these two applications follows this process:

1. Export the current aText snippet list (**Data >> Backup To...**). Ensure that you export a CSV (not an aText) file.
2. Run `expandsync /path/to/your/aText/file.csv`
3. ExpandSync will calculate the snippets that are missing from aText and those that are missing from TextExpander iOs.
4. Unique aText snippets will be automatically imported into TextExpander iOS via Dropbox.
5. ExpandSync will output `aText-snippets.csv` – which contains snippets unique to TextExpander iOS – which can be imported into aText.

# Caveats

* Unfortunately, aText does not allow programmatic access to its snippet database; as such, there is a rather manual nature to this (you most likely won't be running this on a regular cron job).
* Because neither aText nor TextExpander iOS tracks snippets that have been deleted, there's no way to tell both applications to simultaneously delete a snippet. I'm working on a "ask-the-user" method, but in the meantime, snippets will have to be manually deleted from both sides.
* Currently, dynamic text – dates, etc. – are not translated between programs. I'm planning to address in a future version.

# Known Issues & Future Releases

Bugs, issues, and enhancement requests (my own or those submitted by others) can be found on the [Issues Page](https://github.com/bachya/ExpandSync/issues "Open Items").

# Bugs and Feature Requests

To report bugs with or suggest features/changes for Sifttter Redux, please use the [Issues Page](http://github.com/bachya/ExpandSync/issues).

Contributions are welcome and encouraged. To contribute:

1. Fork it ( http://github.com/bachya/expandsync/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# License

(The MIT License)

Copyright © 2014 Aaron Bach bachya1208@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.