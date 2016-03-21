module StanfordCoreNLPResult
  module Grams
    class Ngram
      attr_reader :c
      def initialize(array)
        @c = array
      end

      def contains?(monogram)
        @c.each do |c|
          return true if c.id == monogram.id && c.token == monogram.token
        end
        false
      end

      def contains_word?(word)
        @c.each do |c|
          return true if c.token == word
        end
        false
      end

      def to_s
        @c.map(&:token).join(' ')
      end

      def merge!(a)
        @c = (@c + a).uniq { |x| x.id && x.token }.sort_by(&:id)
      end
    end
  end
end
