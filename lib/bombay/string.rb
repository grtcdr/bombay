# frozen_string_literal: true

# Provides some helpful methods for strings
class String
  # Unquotes a string.
  def unquote
    self.tr('"', "")
  end

  # Expands $HOME.
  def expand
    self.gsub("$HOME", Dir.home)
  end
end
