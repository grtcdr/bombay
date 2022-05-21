# frozen_string_literal: true

require_relative "bombay/version"
require_relative "bombay/string"

require "fileutils"

# This module exposes the methods used to organize your $(pwd).
module Bombay
  class Error < StandardError; end

  def pwd_files
    Dir.entries(FileUtils.pwd)
  end

  def filter_files(regexp)
    pwd_files.keep_if { |ext| ext.match(regexp) }
  end

  def stack(files, dest_dir)
    src_dir = FileUtils.pwd

    return if src_dir == dest_dir
    return if files.empty?

    FileUtils.mkdir(dest_dir) unless File.directory?(dest_dir)

    files.each { |f| FileUtils.mv(f, dest_dir) }
  end
end

# Retrieves the values found inside $XDG_CONFIG_HOME/user-dirs.dirs.
class Directories
  attr_reader :pictures, :videos, :documents

  def config_directory
    ENV["XDG_CONFIG_HOME"] || File.join(Dir.home, ".config")
  end

  def user_dirs_file
    File.join(config_directory, "user-dirs.dirs")
  end

  def xdg_directories
    dirs = {}
    File.open(user_dirs_file).each do |line|
      entry = line.split("=")
      key = entry.first
      value = entry.last.unquote.expand.strip
      dirs.store(key, value)
    end
    dirs
  end

  def initialize
    dirs = xdg_directories
    @documents = dirs["XDG_DOCUMENTS_DIR"]
    @pictures = dirs["XDG_PICTURES_DIR"]
    @videos = dirs["XDG_VIDEOS_DIR"]
  end
end

# Defines the regular expressions used by bombay to
# determine which folder a particular file belongs to.
class Filetypes
  attr_reader :pictures, :videos, :documents

  def initialize
    @pictures = /\.(ico|svg|png|jpe?g|webp|avif)$/
    @videos = /\.(gif|mp4|weba|mpeg)$/
    @documents = /\.(pdf|epub|xml|txt|x?html|pptx?|docx?|rtf|md|org)$/
  end
end
