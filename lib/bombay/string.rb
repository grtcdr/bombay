# frozen_string_literal: true

# Provides some helpful methods for strings
class String
  # Unquotes a string.
  def unquote
    tr('"', "")
  end

  # Expands $HOME.
  def expand
    gsub("$HOME", Dir.home)
  end
end
