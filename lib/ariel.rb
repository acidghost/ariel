require 'ariel/token'
require 'ariel/token_stream'
require 'ariel/learner'
require 'ariel/node_like'
require 'ariel/extracted_node'
require 'ariel/structure_node'
require 'ariel/rule'
require 'ariel/wildcards'
require 'ariel/candidate_selector'
require 'ariel/label_utils'
require 'ariel/example_document_loader'
require 'ariel/rule_set'

if $DEBUG
#  require 'logger'

#  DEBUGLOG = Logger.new(File.open('debug.log', 'wb'))
#  DEBUGLOG.datetime_format = " \010"
#  DEBUGLOG.progname = "\010\010\010"

  def debug(message)
     p message
    #DEBUGLOG.debug message
  end
else
  def debug(message)
  end
end

# = Ariel - A Ruby Information Extraction Library
# Ariel intends to assist in extracting information from semi-structured
# documents including (but not in any way limited to) web pages. Although you
# may use libraries such as Hpricot or Rubyful Soup, or even plain Regular
# Expressions to achieve the same goal, Ariel approaches the problem very
# differently. Ariel relies on the user labeling examples of the data they
# want to extract, and then finds patterns across several such labeled
# examples in order to produce a set of general rules for extracting this
# information from any similar document.
#
# When working with Ariel, your workflow might look something like this:
# 1. Define a structure for the data you wish to extract. For example:
#
#     @structure = Ariel::StructureNode.new do |r|
#       r.article do |a|
#         a.title
#         a.author
#         a.date
#         a.body
#       end
#       r.comment_list do |c|
#         c.author
#         c.date
#         c.body
#       end
#     end
# 2. Label these fields in a few example documents (normally at least 3).
#    Labels are in the form of <tt><l:label_name>...</l:label_name></tt>
# 3. Ariel will read these examples, and try to generate suitable rules that can
#    be used to extract this data from other similarly structured documents.
# 4. A wrapper has been generated - we can now happily load documents with the
#    same structure (normally documents generated by the same rules, so
#    different pages from a single site perhaps) and query the extracted data.
module Ariel



end


