require 'date'
module StanfordCoreNLPResult
  module Helper
    def self.type_guess(value, key = nil)
      return value.to_i if value =~ /^\d+$/
      return value.to_f if value =~ /^\d+\.\d+$/
      return Date.parse(value) if key == :value && value.match(/^\d{4}-\d{1,2}-\d{1,2}$/)
      return value.to_sym if %i(PartOfSpeech NamedEntityTag type).include?(key)
      value.to_s
    end
  end
end
