require_relative './lib/stanford_corenlp_result'

Gem::Specification.new do |s|
  s.name        = 'stanford_corenlp_result'
  s.version     = StanfordCoreNLPResult::VERSION
  s.licenses    = ['MIT']
  s.summary     = "Parses Stanford CoreNLP pipeline's text output into a data structure"
  s.description = 'Stanford CoreNLP is a well established Natural Language Processing kit that annotates free-text with various annotators and returns a parseable output format, that has some major semantic information in it. You can use this gem to parse the resulting text files and have all those semantic information in a handy data structure for further ruby love.'
  s.authors     = ['Hendrik Bergunde']
  s.email       = 'hbergunde@gmx.de'
  s.files       = ['lib/stanford_corenlp_result.rb']
  s.homepage    = 'https://github.com/hendrikb/stanford_corenlp_result-gem'

  s.add_dependency('nokogiri', ['~> 1.6.7'])
  s.add_dependency('pry', ['~> 0.10.3'])

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
