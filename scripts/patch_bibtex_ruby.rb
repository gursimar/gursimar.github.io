# frozen_string_literal: true

require "bundler"

spec = Bundler.load.specs.find { |candidate| candidate.name == "bibtex-ruby" }
abort "bibtex-ruby is not installed; run bundle install first" unless spec

patches = {
  "lib/bibtex/bibliography.rb" => [
    "def each\n      if block_given?\n        data.each(&Proc.new)",
    "def each(&block)\n      if block\n        data.each(&block)"
  ],
  "lib/bibtex/entry.rb" => [
    "def each\n      if block_given?\n        fields.each(&Proc.new)",
    "def each(&block)\n      if block\n        fields.each(&block)"
  ]
}

patches.each do |relative_path, (before, after)|
  path = File.join(spec.full_gem_path, relative_path)
  contents = File.read(path)

  if contents.include?(after)
    puts "Already patched: #{path}"
  elsif contents.include?(before)
    File.write(path, contents.sub(before, after))
    puts "Patched: #{path}"
  else
    abort "Could not recognize #{path}; the installed gem may have changed"
  end
end
