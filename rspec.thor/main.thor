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
      
=begin
      puts
      puts "libclass called #{name} #{options.inspect}"
      puts "Rspec.source_root: #{Rspec.source_root.inspect}"
      puts "`ls #{Rspec.source_root}`: #{`ls #{Rspec.source_root}`.inspect}"
      puts
=end

      empty_directory("spec")
      empty_directory("spec/#{@project}")
      
      opts = {
        :name    => name, 
        :project => Rspec.project
      }

      template("templates/libclass/class.rb.tt",
        "lib/#{opts[:project]}/#{name}.rb", opts)
      template("templates/libclass/spec.rb.tt",
        "spec/#{opts[:project]}/#{name}_spec.rb", opts)
      
      
    end
  
  
end
