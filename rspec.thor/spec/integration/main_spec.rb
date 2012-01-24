require File.join(File.dirname(__FILE__), '../spec_helper')

describe 'thor rspec' do
  
  context 'libclass' do
    before :all do
      clean
      setup_existing_project_in_sandbox
    end
   
    context "foo (class with no namespace)" do
      before(:each) do
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
  end
end

