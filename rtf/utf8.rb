module RTF
  # Modifies the TextNode class to manage utf8 character strings
  class TextNode < Node
    # This method generates the RTF equivalent for a TextNode object. This
    # method escapes any special sequences that appear in the text.
    def to_rtf
      _text = @text || ''
      _text = _text.gsub("\\", "\\\\\\").gsub("{", "\\{").gsub("}", "\\}")
      _text.unpack('U*').map { |n| n < 128 ? n.chr : n < 256 ? "\\'#{n.to_s(16)}" : "\\u#{n}\\'3f" }.join('')
    end
  end
end
