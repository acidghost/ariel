module Ariel  
      WILDCARDS = {
        :anything=>/.+/,
        :numeric=>/\d+/,
        :alpha_numeric=>/\w+/,
        :alpha=>/[[:alpha:]]+/,
        :capitalized=>/[[:upper:]]+\w+/,
        :all_caps=>/[[:upper:]]+/,
        :html_tag=>/<\/?\w+>/,
        :punctuation=>/[[:punct:]]+/
      }

  # Tokens populate a TokenStream. They know their position in the original
  # document, can list the wildcards that match them and determine whether a
  # given string or wildcard is a valid match.
  class Token
  attr_reader :text, :start_loc, :end_loc
    
    # Each new Token must have a string representing its content, its start position in the
    # original document (start_loc) and the point at which it ends (end_loc).
    # For instance, in the String "This is an example", if "is" were to be made a
    # Token it would be given a start_loc of 5 and and end_loc of 7.
    def initialize(text, start_loc, end_loc)
      @text=text.to_s
      raise ArgumentError, "end_loc - start_loc != token length" if (end_loc - start_loc) != @text.size
      @start_loc=start_loc
      @end_loc=end_loc
    end
    
    # Tokens are only equal if they have an equal start_loc, end_loc and text.
    def ==(t)
      return (@start_loc==t.start_loc && @end_loc==t.end_loc && @text==t.text)
    end
      
    # Accepts either a string or symbol representing a wildcard in the WILDCARDS
    # hash. Returns true if the whole Token is consumed by the wildcard or the
    # string is equal to Token#text, and false if the match fails.
    def matches?(landmark)
      if landmark.kind_of? Symbol
        raise ArgumentError, "#{landmark} is not a valid wildcard." unless WILDCARDS.has_key? landmark
        md = WILDCARDS[landmark].match(self.text)
        return false if md.nil?
        return true if md[0].length == self.text.length  #Regex must match the whole token
      else
        return true if landmark==self.text
      end
      return false
    end

    # Returns an array of symbols corresponding to the Wildcards that match the
    # Token.
    def matching_wildcards
      matches = Array.new
      WILDCARDS.each do |name, regex|
        (matches << name) if self.matches?(name)
      end
      return matches
    end
  end
end