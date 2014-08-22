require 'open-uri'
require 'find_artifacts'

class Updater
  $discover = FindArtifacts.new

  def retrieval(url, name)
    open(url) {|f|
      f.each_line {|line|
        str = line.to_str
        if str.start_with?("#")
        else
          $discover.domain(str, url, name)
          $discover.ipv4(str, url, name)
        end}
      }
  end

  def dedupe(artifact)
    # Checks database to see if value already exists

  end
end
