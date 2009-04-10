module RTF
  # Extends the command node with a method for adding hyperlinks.
  class CommandNode < ContainerNode
    # This method adds an hyperlink in the flow of text.
      #
      # ==== Parameters
      # url::    The URL of the hyperlink.
      # text::   The text to be displayed and underlined where the hyperlink
      #          shows up in the document. By default, the URL is used for the
      #          text.
    def hyperlink(url, text=nil)
      # an hyperlink is a field
      field_node = CommandNode.new(self, '\field')
      # inside the field is a node for specifying the URL...
      fldinst_node = CommandNode.new(field_node, '\*\fldinst')
      fldinst_node.store(TextNode.new(fldinst_node, "HYPERLINK \"#{url}\""))
      field_node.store(fldinst_node)
      # ...followed by a node for specifying the text
      fldrslt_node = CommandNode.new(field_node, '\fldrslt \ul')
      fldrslt_node.store(TextNode.new(fldrslt_node, text || url))
      field_node.store(fldrslt_node)
      
      store(field_node)
    end
  end
end
