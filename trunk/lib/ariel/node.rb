module Ariel
 
  class Node
    removed_methods=[:id, :type]
    removed_methods.each {|meth| undef_method meth}
    attr_accessor :parent, :children, :node_name

    def initialize(name)
      @children={}
      if name.kind_of? String
				@node_name=name.to_sym
			else
				@node_name=name
			end
    end

    # Given a Node object and a name, adds a child to the array of children,
    # setting its parent as the current node, as well as creating an accessor
    # method matching that name.
    def add_child(node) 
      @children[node.node_name]=node
      node.parent = self
      # Trick stolen from OpenStruct
      meta = class << self; self; end
      meta.send(:define_method, node.node_name.to_s.to_sym) {@children[node.node_name]}
    end

    def each_descendant(include_self=false)
      if include_self
        node_queue=[self]
      else
        node_queue=self.children.values
      end
      until node_queue.empty? do
        node_queue.concat node_queue.first.children.values
        yield node_queue.shift
      end
    end
  end
end