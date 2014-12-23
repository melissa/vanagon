require 'vanagon/utilities'

class Vanagon
  class Component
    class Source
      class Git
        include Vanagon::Utilities
        attr_accessor :url, :ref, :workdir, :version

        def initialize(url, ref, workdir)
          unless ref
            fail "ref parameter is required for the git source"
          end
          @url = url
          @ref = ref
          @workdir = workdir
        end

        def fetch
          Dir.chdir(@workdir) do
            git('clone', '--recursive', @url)
            Dir.chdir(dirname) do
              git('checkout', @ref)
              @version = git_version
            end
          end
        end

        def verify
          # nothing to do here, so just return
        end

        def dirname
          File.basename(@url).sub(/\.git/, '')
        end

        def extract
          # Nothing to extract
          return nil
        end
      end
    end
  end
end