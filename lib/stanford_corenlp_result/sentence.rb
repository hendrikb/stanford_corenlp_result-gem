module StanfordCoreNLPResult
  class Sentence < Array
    attr_reader :tokens, :description, :clear_text
    def initialize(token_list, description, clear_text)
      @tokens = token_list
      @description = description
      @clear_text = clear_text
    end

    def to_s
      "#{@description} - #{@clear_text}"
    end
  end
end
