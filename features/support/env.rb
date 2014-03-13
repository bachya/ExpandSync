require 'aruba/cucumber'
require 'methadone/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')
RES_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','res')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
  @original_home = ENV['HOME']
  ENV['HOME'] = "/tmp/expandsync"
  
  FileUtils.rm_rf "/tmp/expandsync"
  FileUtils.mkdir "/tmp/expandsync"
  FileUtils.mkdir "/tmp/expandsync/input"
  FileUtils.mkdir "/tmp/expandsync/output"
  FileUtils.mkdir_p "/tmp/expandsync/Dropbox/TextExpander"
  
  FileUtils.cp(File.join(RES_DIR, 'atext.csv'), '/tmp/expandsync/input/atext.csv')
  FileUtils.cp(File.join(RES_DIR, 'random-text-file.txt'), '/tmp/expandsync/input/random-text-file.txt')
  FileUtils.cp(File.join(RES_DIR, 'Settings.textexpander'), '/tmp/expandsync/Dropbox/TextExpander')
end

After do
  ENV['RUBYLIB'] = @original_rubylib
  ENV['HOME'] = @original_home
end
