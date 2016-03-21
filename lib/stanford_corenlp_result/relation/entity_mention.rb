module StanfordCoreNLPResult
  module Relation
    class EntityMention
      attr_reader :type, :objectId, :hstart, :hend, :estart, :eend, :headPosition, :value, :corefID
      def initialize(params)
        @type         = params[:type]
        @objectId     = params[:objectId]
        @hstart       = params[:hstart]
        @hend         = params[:hend]
        @estart       = params[:estart]
        @eend         = params[:eend]
        @headPosition = params[:headPosition]
        @value        = params[:value]
        @corefID      = params[:corefID]
      end

      def self.from_line(line)
        params = line.strip.match(/^EntityMention \[(.*)\]$/)[1]
                 .split(',').map { |p| p.split('=') }.map do |p|
          new_key = p[0].strip.to_sym
          { new_key => attr_value_helper(new_key, p[1]) }
        end.reduce({}, :merge)
        EntityMention.new(params)
      end

      def self.attr_value_helper(name, string_value)
        case name
        when :type
          return string_value.to_sym
        when :objectId
          return string_value.to_s
        when :value
          return string_value.gsub(/(^"|"$)/, '')
        else
          return string_value.to_i
        end
      end
    end
  end
end
