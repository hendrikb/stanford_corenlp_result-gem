module StanfordCoreNLPResult
  module Relation
    class RelationMention
      attr_reader :line, :start, :end, :probabilities, :type
      def initialize(pos_start, pos_end, probabilities)
        @start = pos_start
        @end = pos_end
        @probabilities = probabilities
        @type = probabilities.sort_by { |_, value| value }.last[0]
      end

      def self.from_line(line)
        m = line.match(/RelationMention \[type=(\w+), start=(\d+), end=(\d+), {(.+)}/)

        probabilities = parse_probabilities(m[4])
        new(m[1].to_i, m[2].to_i, probabilities)
      end

      def self.parse_probabilities(probabilities)
        probabilities.split(';').map do |p|
          {
            p.split(',')[0].to_s.strip.to_sym => p.split(',')[1].to_f
          }
        end.reduce({}, :merge)
      end
    end
  end
end
