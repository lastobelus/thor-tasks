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
      module_namespace_path = nil
      module_name = nil

      if namespace.length > 1 && (namespace.first == "")
        # absolute namespace
        namespace.shift
        module_inc = namespace.join('/')
        name = namespace.pop
        module_name = namespace[0]
        module_path = ''
      else
        module_inc = namespace.join('/')
        name = namespace.pop
        namespace.unshift Rspec.project
        module_name = namespace[1]
        module_path = namespace[0]
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
      
      if module_name
        inc_file = "lib/#{module_path}/#{module_name}.rb"
        inc = %Q{require "#{module_inc}"}
        if File.exists? inc_file
          append_file(inc_file, inc)          
        else
          create_file(inc_file, inc)
        end
      end
      
      template("templates/libclass/class.rb.tt",
        "lib/#{namespace_path}/#{name}.rb", opts)
      template("templates/libclass/spec.rb.tt",
        "spec/#{namespace_path}/#{name}_spec.rb", opts)
      
      
    end
  
  
end
