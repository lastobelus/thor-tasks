require "active_support/inflector"

class Rspec < Thor
  include Thor::Actions
  attr_reader :name
  
  class << self
    def source_root
      File.dirname(__FILE__)
    end
    
    def project
      # first priority, name of dir in lib if there is only one
      # second priority, basename of rb file in lib if there is only one
      # third priority basename of cwd
      File.basename(Dir.pwd)      
    end
    
  end
  

  
    desc 'libclass NAME', 'Generate a new class file with a matching spec'
    def libclass(name)
      
      namespace = name.split(/[\/:]+/)
      name = namespace.pop

      if namespace.length > 0 && (namespace.first == "")
        namespace.shift
      else
        namespace.unshift Rspec.project
      end

      namespace_path = namespace.join('/')

      opts = {
        :name           => name, 
        :namespace      => namespace,
        :module_name    => namespace_path.camelize
      }

      empty_directory("spec")
      empty_directory("spec/#{@namespace_path}")
      empty_directory("lib/#{@namespace_path}")
      
      template("templates/libclass/class.rb.tt",
        "lib/#{namespace_path}/#{name}.rb", opts)
      template("templates/libclass/spec.rb.tt",
        "spec/#{namespace_path}/#{name}_spec.rb", opts)
      
      
    end
  
  
end
