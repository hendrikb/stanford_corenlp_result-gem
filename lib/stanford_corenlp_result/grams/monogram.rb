module StanfordCoreNLPResult
  module Grams
    class Monogram
      attr_reader :token, :id

      def initialize(token, id)
        @token = token
        @id = id
      end

      def to_s
        inspect
      end

      def inspect
        "#{@token}-#{@id}"
      end

      def ==(other)
        id == other.id && token == other.token
      end
    end
  end
end
