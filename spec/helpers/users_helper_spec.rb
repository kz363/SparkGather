require "spec_helper"

describe UsersHelper do
  describe "#info_box" do
  	let(:output){ info_box('Basic System Information', {
									'User Agent' => 'test1',
									'OS' => 'test2',
									'Browser' => 'test3',
									'Mobile' => 'test4',
									'Screen Resolution' => 'test5',
									'Window Size' => 'test6' }) }

  	it 'should return an ActiveSupport::SafeBuffer' do
  		expect(output).to be_a(ActiveSupport::SafeBuffer)
  	end
  	
  	it 'should return a properly formatted <th> and <tr> tag' do
  		expect(output).to eq('<th class="sub-title" colspan="2">Basic System Information</th><tr><td>User Agent</td><td>test1</td></tr><tr><td>OS</td><td>test2</td></tr><tr><td>Browser</td><td>test3</td></tr><tr><td>Mobile</td><td>test4</td></tr><tr><td>Screen Resolution</td><td>test5</td></tr><tr><td>Window Size</td><td>test6</td></tr>')
  	end
  end
end