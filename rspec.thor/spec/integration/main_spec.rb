require File.join(File.dirname(__FILE__), '../spec_helper')

describe 'thor rspec' do
  
  context 'libclass' do
    context "foo (class with no namespace)" do
      before(:all) do
        clean
        setup_existing_project_in_sandbox
        thor('rspec libclass foo')
      end
      
      context "class file" do
        let(:class_file) { 'lib/sandbox/foo.rb' }
        specify { file( class_file ).should exist }
        
        it "should be a namespaced to the project" do
          file( class_file ).contents.should match %r{
            module\ Sandbox\s+
              class\ Foo
                .*
              end\s+
            end$
          }mx
        end
      end 
      
      context "spec file" do
        let(:spec_file) { 'spec/sandbox/foo_spec.rb' }

        specify { file( spec_file ).should exist  }
        
        it "should be a namespaced to the project" do
          file( spec_file ).contents.should match %r{
            describe\ Sandbox::Foo\ do\s+
              .*
            end$
          }mx
        end
      end
    end

    context "baz:qux (class with relative namespace)" do
      before(:all) do
        clean
        setup_existing_project_in_sandbox
        thor('rspec libclass baz:qux')
      end
      
      context "module file" do
        subject {'lib/sandbox/baz.rb'}      
        specify { file( subject ).should exist }
        
        it "should include the class file" do
          file( subject ).contents.should match %r{
            require\ "baz/qux"
          }x
        end
      end
      
      context "class file" do
        let(:namespace_dir) { 'lib/sandbox/baz' }
        let(:class_file) { "#{namespace_dir}/qux.rb" }

        specify { file( namespace_dir ).should exist }
        specify { file( class_file ).should exist }
        
        it "should be a namespaced to the project" do
          # we have to live with an extra newline on 
          # the end because fuck you, ERB
          file( class_file ).contents.should match %r{
            module\ Sandbox\s+
              module\ Baz\s+
                class\ Qux\s+
                .*
                end\s+
              end\s+
            end\Z
          }mx
        end
      end 
      
      context "spec file" do
        let(:spec_file) { 'spec/sandbox/baz/qux_spec.rb' }

        specify { file( spec_file ).should exist  }
        
        it "should be a namespaced to the project" do
          file( spec_file ).contents.should match %r{
            describe\ Sandbox::Baz::Qux\ do\s+
              .*
            end$
          }mx
        end
      end
    end

    context ":corge:grault:garply (class with absolute namespace)" do
      before(:all) do
        clean
        setup_existing_project_in_sandbox
        thor('rspec libclass /corge/grault/garply')
      end
      
      context "module file" do
        subject {'lib/corge.rb'}      
        specify { file( subject ).should exist }
        
        it "should include the class file" do
          file( subject ).contents.should match %r{
            require\ "corge/grault/garply"
          }x
        end
      end

      context "class file" do
        let(:namespace_dir) { 'lib/corge/grault' }
        let(:class_file) { "#{namespace_dir}/garply.rb" }

        specify { file( namespace_dir ).should exist }
        specify { file( class_file ).should exist }
        
        it "should be namespaced to the project" do
          # we have to live with an extra newline on 
          # the end because fuck you, ERB
          file( class_file ).contents.should match %r{
            module\ Corge\s+
              module\ Grault\s+
                class\ Garply\s+
                .*
                end\s+
              end\s+
            end\Z
          }mx
        end
      end 
      
      context "spec file" do
        let(:spec_file) { 'spec/corge/grault/garply_spec.rb' }

        specify { file( spec_file ).should exist  }
        
        it "should be a namespaced to the project" do
          file( spec_file ).contents.should match %r{
            describe\ Corge::Grault::Garply\ do\s+
              .*
            end$
          }mx
        end
      end
    end

    
  end
end