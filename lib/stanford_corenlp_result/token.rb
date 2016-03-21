require 'nokogiri'
module StanfordCoreNLPResult
  class Token
    attr_reader :token, :parameters
    def initialize(token, parameters = {})
      @token = token
      @paramters = parameters
    end

    def to_s
      @token
    end

    def self.from_line(line)
      m = line.match(/^\[Text=(\S+) (.*)\]$/)
      token = m[1]
      parameters = parse_parameters(m[2])
      new(token, parameters)
    end

    def self.parse_parameters(parameters_string)
      if parameters_string =~ /Timex=/
        timex = parameters_string.match(/Timex=(.*)$/)

        parameters = parameters_string.sub(timex[0], '').split(' ').map do |t|
          key = t.split('=')[0].to_sym
          value = if t.split('=')[1].nil?
                    ''
                  else
                    StanfordCoreNLPResult::Helper.type_guess(t.split('=')[1], key)
                  end
          { key => value }
        end.reduce Hash.new, :merge
        return parameters.merge!(timex: parse_timex(timex[1]))
      else
        return  parameters_string.split(' ').map do |t|
          key = t.split('=')[0].to_sym
          value = StanfordCoreNLPResult::Helper.type_guess(t.split('=')[1], key)
          { key => value }
        end.reduce Hash.new, :merge
      end
    end

    def self.parse_timex(timex_string)
      timex = {}
      xml = Nokogiri::XML(timex_string)
      xml.children.each do |child|
        child.attributes.each do |a|
          value = StanfordCoreNLPResult::Helper.type_guess(a[1].value, a[0].to_sym)
          timex[a[0].to_sym] = value
        end
      end

      timex.merge!(content: xml.children.last.children.first.text)
    end
  end
end
