require 'rake/clean'
require 'rubygems'

def version
  contents = File.read File.expand_path('../lib/expandsync/constants.rb', __FILE__)
  contents[/\sVERSION = '([^']+)'/, 1]
end

spec = eval(File.read('expandsync.gemspec'))

require 'rake/testtask'
desc 'Run unit tests'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

require 'cucumber'
require 'cucumber/rake/task'
CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
desc 'Run Cucumber features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts =  opts
  t.fork = false
end

desc "Release ExpandSync version #{ version }"
task :release => :build do
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  
  sh "git commit --allow-empty -a -m 'Release #{ version }'"
  sh "git tag v#{ version }"
  sh "git push origin master"
  sh "git push origin v#{ version }"
  sh "gem push pkg/expandsync-#{ version }.gem"
end

desc "Build the gem"
task :build do
  FileUtils.mkdir_p "pkg"
  sh "gem build expandsync.gemspec"
  FileUtils.mv("./expandsync-#{ version }.gem", "pkg")
end

task :default => [:test, :features]
