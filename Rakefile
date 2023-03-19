# frozen_string_literal: true

require 'rake/packagetask'

# Rake::PackageTask.new("library", "1.0") do |pt|
#   puts("Packaging library distribution artifact...")
#   pt.need_zip = true
#   pt.package_files = ["app.rb", 'config/*.rb']
# end
#

file 'pkg' do |t|
  mkdir t.name
end

desc 'bundle gems for deployment'
task :bundle_gems do
  # bundle for deployment
  sh 'bundle config set BUNDLE_DEPLOYMENT true'
  sh 'bundle install'
end

desc 'Build the application archive'
task :build_archive, [:archive_name], %w[pkg bundle_gems] do |_, args|
  version = File.read('VERSION').strip
  puts "version '#{version}'"
  # Set the name of the archive file
  archive_name = "pkg/#{args[:archive_name]}_#{version}.zip"

  puts "archive_name '#{archive_name}'"

  # Create an array of the files and directories to include in the archive
  files_to_include = %w[app.rb VERSION watch_me config/ vendor/bundle/ config.ru .ruby-version Gemfile Gemfile.lock
                        .bundle/]

  # Use the `zip` command to create the archive
  sh "zip -r #{archive_name} #{files_to_include.join(' ')}"

  # sh 'bundle config unset BUNDLE_DEPLOYMENT'
end
