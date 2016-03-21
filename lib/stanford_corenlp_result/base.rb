module StanfordCoreNLPResult
  class Base
    attr_reader :ngrams, :relations, :sentences
    def initialize(text)
      lines = text.split("\n")
      parse_sentences(lines)
      parse_ngrams!(lines)
      parse_relationships(lines)
    end

    def tokens_from_word(needle)
      @sentences.flatten.select {|t| t.token == needle}
    end

    private

    def parse_sentences(lines)
      @sentences = []
      cur_sentence = nil
      lines.each_with_index do |line, i|
        if line.start_with?('Sentence #')
          @sentences << cur_sentence if cur_sentence
          description = line
          cur_sentence = StanfordCoreNLPResult::Sentence.new(description, lines[i + 1])
        end
        cur_sentence << StanfordCoreNLPResult::Token.from_line(line) if line.start_with?('[Text=')
      end
    end

    def parse_ngrams!(lines)
      @ngrams = []
      bigrams = []
      lines.each_with_index do |line, _i|
        # puts "Parsing line #{i}: #{line}"
        next unless line.start_with?('compound(')
        begin
          bigrams << parse_bigram(line)
        rescue RuntimeError => e
          $stderr.puts e.message
        end
      end
      match_ngrams(bigrams)
    end

    def parse_bigram(line)
      match = line.match(/^compound\((.+)-(\d+), (.+)-(\d+)\)$/)
      raise "Not a proper match: #{line}" if match.nil?
      c1 = StanfordCoreNLPResult::Grams::Monogram.new(match[1], match[2].to_i)
      c2 = StanfordCoreNLPResult::Grams::Monogram.new(match[3], match[4].to_i)
      [c1, c2].sort_by!(&:id)
    end

    def match_ngrams(bigrams)
      bigrams.each do |a|
        left = a[0]
        right = a[1]
        merged = false
        @ngrams.each do |c|
          if c.contains?(left) || c.contains?(right)
            c.merge!(a)
            merged = true
          end
        end
        @ngrams << StanfordCoreNLPResult::Grams::Ngram.new(a) unless merged
      end
    end

    def parse_relationships(lines)
      @relations = []
      lines.each_with_index do |line, i|
        next unless line.start_with?('RelationMention')
        rm = StanfordCoreNLPResult::Relation::RelationMention.from_line(line)
        em1 = StanfordCoreNLPResult::Relation::EntityMention.from_line(lines[i + 1])
        em2 = StanfordCoreNLPResult::Relation::EntityMention.from_line(lines[i + 2])
        @relations << StanfordCoreNLPResult::Relation::Base.new(rm, em1, em2)
      end
    end
  end
end
