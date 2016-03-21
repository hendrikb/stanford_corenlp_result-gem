module StanfordCoreNLPResult
  class Sentence < Array
    attr_reader :description, :clear_text
    def initialize(description, clear_text)
      @description = description
      @clear_text = clear_text
    end

    def to_s
      "#{@description} - #{@clear_text}"
    end
  end
end
