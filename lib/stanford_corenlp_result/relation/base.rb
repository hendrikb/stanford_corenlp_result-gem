module StanfordCoreNLPResult
  module Relation
    class Base
      attr_reader :relation_mention, :left, :right, :type
      def initialize(relation_mention, entity_mention_left, entity_mention_right)
        @relation_mention = relation_mention
        @type = relation_mention.type
        @left = entity_mention_left
        @right = entity_mention_right
      end

      def to_s
        "#{@left.value}(#{@left.type}) --#{@type}--> #{@right.value}(#{@right.type})"
      end
    end
  end
end
