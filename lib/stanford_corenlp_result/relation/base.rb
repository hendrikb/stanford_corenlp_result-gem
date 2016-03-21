module StanfordCoreNLPResult
  module Relation
    class Base
      attr_reader :relation_mention, :entity_mentions
      def initialize(relation_mention, entity_mention_left, entity_mention_right)
        @relation_mention = relation_mention
        @entity_mentions = [entity_mention_left, entity_mention_right]
      end

      def to_s
        "#{@entity_mentions[0].value}(#{@entity_mentions[0].type}) --#{@relation_mention.type}--> #{entity_mentions[1].value}(#{entity_mentions[1].type})"
      end
    end
  end
end
