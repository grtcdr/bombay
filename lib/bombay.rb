# frozen_string_literal: true

require_relative "bombay/version"
require_relative "bombay/string"

require "fileutils"
require "os"

# This module exposes the methods used
# to organize the working directory.
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

# Stores the system directories.
class Directories
  attr_reader :pictures, :videos, :documents

  def config_directory
    ENV["XDG_CONFIG_HOME"] || File.join(Dir.home, ".config")
  end

  def xdg_directory_type(dir)
    dir.delete_prefix("XDG_").delete_suffix("_DIR")
  end

  def user_dirs_file
    File.join(config_directory, "user-dirs.dirs")
  end

  def xdg_directories
    dirs = {}
    File.open(user_dirs_file).each do |line|
      next if line.start_with?("#")
      next if line.strip.empty?
      
      entry = line.split("=")
      key = xdg_directory_type(entry.first)
      value = entry.last.unquote.expand.strip
      dirs.store(key, value)
    end
    dirs
  end

  def macos_directories
    dirs = {}
    dirs.store("DOCUMENTS", File.join(Dir.home, "Documents"))
    dirs.store("PICTURES", File.join(Dir.home, "Pictures"))
    dirs.store("VIDEOS", File.join(Dir.home, "Movies"))
    dirs
  end

  def initialize
    dirs = if OS.linux?
             xdg_directories
           elsif OS.macos?
             macos_directories
           else
             abort("Unsupported platform.")
           end

    @documents = dirs["DOCUMENTS"]
    @pictures = dirs["PICTURES"]
    @videos = dirs["VIDEOS"]
  end
end

# Defines the regular expressions used by bombay to determine which
# system directory a particular file belongs to.
class Filetypes
  attr_reader :pictures, :videos, :documents

  def initialize
    @pictures = /\.(ico|svg|png|jpe?g|webp|avif)$/
    @videos = /\.(gif|mp4|weba|mpeg)$/
    @documents = /\.(pdf|epub|xml|txt|x?html|pptx?|docx?|rtf|md|org)$/
  end
end
